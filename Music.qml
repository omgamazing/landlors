import QtQuick
import QtMultimedia
Item {
    property alias backgroundMusic: backgroundMusic
    MediaPlayer{
       id:backgroundMusic
       source: "qrc:/music/MusicEx_Normal.mp3"
       loops:MediaPlayer.Infinite
       audioOutput: AudioOutput{}
    }

}
