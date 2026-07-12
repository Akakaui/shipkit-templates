# Video Workflow (Remotion)

## Pipeline

```
Script → Scene Breakdown → Source Assets → Generate Audio → Compose Remotion → Render MP4
```

## Step 1: Get the Script

- User provides script/topic
- I write the script from a topic
- Collaborative: user writes, I enhance

Save script to `./script.md`

## Step 2: Scene Breakdown

Each scene needs:

```yaml
scenes:
  - id: 01
    duration: 5  # seconds
    narration: "Welcome to our product..."
    visuals:
      - type: video  # or image, 3d, animation
        source: generated  # fetched, generated, or user-uploaded
        description: "Cinematic shot of product on pedestal"
    transitions: fade  # cut, fade, slide, zoom
    audio: narration
```

## Step 3: Ask Before Render

Always ask:
1. **Output format:** 16:9 (YouTube), 9:16 (Reels/Shorts), 1:1 (Instagram), or custom
2. **Voice-over:** ElevenLabs voice ID or user-provided audio file
3. **Total duration target**

## Step 4: Generate/Source Assets

Run per scene:

```bash
# Create asset folder
mkdir -p assets/scene-{id}

# Generate background video via Higgsfield
# (Higgsfield MCP call)

# Generate images via Higgsfield
# (Higgsfield MCP call)

# Fetch from web if needed
agent-browser open "<source-url>"
# download or screenshot

# User uploads if can't find/generate
# Ask user for the file
```

## Step 5: Generate Voice-Over

```bash
# ElevenLabs TTS API call
curl -s -X POST "https://api.elevenlabs.io/v1/text-to-speech/<voice-id>" \
  -H "xi-api-key: $ELEVENLABS_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Narration text for this scene...",
    "model_id": "eleven_multilingual_v2",
    "voice_settings": { "stability": 0.5, "similarity_boost": 0.75 }
  }' \
  -o "assets/scene-{id}/narration.mp3"
```

## Step 6: Compose Remotion Project

Create a Remotion project structure:

```
remotion-project/
├── src/
│   ├── Root.tsx          # Main composition
│   ├── composition.ts    # Video config
│   └── scenes/
│       ├── Scene01.tsx   # Per-scene component
│       └── Scene02.tsx
├── public/
│   └── assets/           # Scene assets symlinked/copied
├── package.json
└── remotion.config.ts
```

Scene component pattern:

```tsx
// src/scenes/Scene01.tsx
import { AbsoluteFill, Audio, Img, Sequence, useVideoConfig } from 'remotion';

export const Scene01: React.FC<{ narration: string; image: string }> = ({
  narration,
  image,
}) => {
  return (
    <AbsoluteFill>
      <Img src={image} />
      <Audio src={narration} />
    </AbsoluteFill>
  );
};
```

## Step 7: Render

```bash
cd remotion-project
npx remotion render src/index.ts MyComposition output.mp4
```

## Step 8: Deliver

- Provide the MP4 file path
- Ask if they want changes (different format, cuts, audio swap, etc.)
