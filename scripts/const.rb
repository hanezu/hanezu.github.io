module ConstantModule
  class CONST
    EXTENSIONS = {
        audio: {
            '.ogg' => 'audio/ogg',
            '.mp3' => 'audio/mpeg',
        },
        video: {
            '.webm' => 'video/webm',
            '.mp4' => 'video/mp4',
        }
    }
  end
end