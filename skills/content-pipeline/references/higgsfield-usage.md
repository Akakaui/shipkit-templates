# Higgsfield + MCP Tools Reference

## Higgsfield (Image + Video Generation)

Higgsfield handles all image and video generation for the pipeline.

### Image Generation
- Generates custom images for web designs and video scenes
- Uses prompts with style references
- Output: PNG/JPG files saved to asset folders

### Video Generation
- Cinematic video scenes from text prompts
- Scene-to-video matching (describe the scene, get a video clip)
- Output: MP4 files

### Integration
- MCP server (install later via `npx` or CLI)
- REST API as fallback
- API key from user

## ElevenLabs (Voice-Over / Narration)

### Text-to-Speech
- Generates narration for video scenes
- Multiple voice options (ask user which voice)
- Output: MP3 files per scene

### API Pattern
```bash
curl -s -X POST "https://api.elevenlabs.io/v1/text-to-speech/<voice-id>" \
  -H "xi-api-key: $ELEVENLABS_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Narration text here...",
    "model_id": "eleven_multilingual_v2",
    "voice_settings": {
      "stability": 0.5,
      "similarity_boost": 0.75
    }
  }' \
  -o "assets/scene-{id}/narration.mp3"
```

### Voice IDs
- Ask user which voice per project
- Store commonly used voice IDs for reuse

## Remotion (Video Composition)

### Project Setup
```bash
mkdir remotion-project && cd remotion-project
npx remotion init
```

### Render
```bash
npx remotion render src/index.ts MyComposition output.mp4
```

### Scene Composition
- Each scene is a `<Sequence>` component
- Audio via `<Audio>` component
- Images via `<Img>` component
- Video via `<Video>` component
- 3D via `@react-three/fiber` + `<ThreeCanvas>`

## Asset Fetching (agent-browser)

### Download Image from Page
```bash
agent-browser open "<url>"
agent-browser get attr "<selector>" src
# then curl the src URL
```

### Screenshot Element
```bash
agent-browser screenshot "element-name.png"
```
