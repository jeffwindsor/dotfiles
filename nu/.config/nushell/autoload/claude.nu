
def claude_bedrock [] {
  # CJ Claude Bedrock Experiment
  $env.CLAUDE_CODE_USE_BEDROCK = "1"
  $env.AWS_REGION = "us-west-2"
  $env.ANTHROPIC_MODEL = "us.anthropic.claude-sonnet-4-20250514-v1:0"
  $env.ANTHROPIC_SMALL_FAST_MODEL = "us.anthropic.claude-3-5-haiku-20241022-v1:0"
}
