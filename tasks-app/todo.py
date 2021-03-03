import jinja2
import aiosqlite
import aiohttp_jinja2
from aiohttp import web

routes = web.RouteTableDef()


async def create_db_connection(app: web.Application):
    app['db_connection'] = await aiosqlite.connect('tasks.sqlite')


async def close_db_connection(app):
    await app['db_connection'].close()


@routes.get('/', name='main')
@aiohttp_jinja2.template('main.jinja2')
async def main(request: web.Request) -> web.Response:
    cursor = await app['db_connection'].execute('SELECT * FROM tasks')
    rows = await cursor.fetchall()
    return {'tasks': rows}


@routes.post('/add')
async def add(request: web.Request) -> web.Response:
    data = await request.post()
    db_connection = app['db_connection']
    await db_connection.execute("INSERT INTO tasks (body, status) VALUES (?, 'open')", [data['taskBody']])
    await db_connection.commit()
    raise web.HTTPFound(location=request.app.router['main'].url_for())


@routes.post('/change')
async def change(request: web.Request) -> web.Response:
    data = await request.post()
    db_connection = app['db_connection']
    await db_connection.execute('UPDATE tasks SET status=? WHERE task_id=?', [data['targetStatus'], data['taskId']])
    raise web.HTTPFound(location=request.app.router['main'].url_for())

if __name__ == '__main__':
    app = web.Application()
    app.add_routes(routes)
    app.on_startup.append(create_db_connection)
    app.on_shutdown.append(close_db_connection)
    aiohttp_jinja2.setup(app, loader=jinja2.FileSystemLoader('templates'))

    web.run_app(app)
