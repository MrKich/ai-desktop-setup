locals {
  models = {
    "qwen3.5-2b" : {}
    "qwen3.5-35b" : {
      capabilities = {
        citations : true # TODO: это добавляет контекста. возможно стоит убрать
        code_interpreter : true
        file_upload : true
        image_generation : true
        status_updates : true
        vision : true
        web_search : true
      }
      default_feature_ids = ["code_interpreter", "web_search"]
      tool_ids = ["server:sequential-thinking", "subagent"]
    }
  }

  tools = {
    subagent = {
      url = "https://raw.githubusercontent.com/Skyzi000/open-webui-extensions/refs/heads/main/tools/sub_agent.py"
    }
  }
}

data "http" "this" {
  for_each = local.tools
  url = each.value.url
}

resource "openwebui_tool" "this" {
  for_each = local.tools

  tool_id = each.key
  name = each.key
  content = data.http.this[each.key].response_body

  lifecycle {
    ignore_changes = [user_id]
  }
}

resource "openwebui_model" "this" {
  for_each = local.models

  model_id = each.key
  name     = each.key

  capabilities = try(each.value.capabilities, {})
  default_feature_ids = try(each.value.default_feature_ids, [])

  params = {
    function_calling = "native"
    system           = file("${path.module}/prompts/system/${each.key}.md")
  }

  tool_ids = try(each.value.tool_ids, null)

  lifecycle {
    ignore_changes = [user_id]
  }
}
