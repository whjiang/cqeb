# -*- coding: utf-8 -*-

import pystache
import json
from pystache.common import TemplateNotFoundError
from pystache.renderer import Renderer
import codecs

#定义生成函数
def render(template, context, out):
    renderer = Renderer(file_encoding="utf-8")

    try:
        template = renderer.load_template(template)
    except TemplateNotFoundError:
        pass

    try:
        context = json.load(open(context))
    except IOError:
        context = json.loads(context)

    rendered = renderer.render(template, context)

    file = codecs.open(out, "w", "utf-8")
    file.write(rendered)
    file.close()

#进行模板生成，模板文件是schema.mustache。这里必须把后缀去掉
render("schema", "cqkm.json", "../cqkm.schema.yaml")
render("schema", "cqyx.json", "../cqyx.schema.yaml")
render("schema", "cqlb.json", "../cqlb.schema.yaml")
