function initVideoCall(){

  const localMedia = document.getElementById('local-media');

  if (localMedia) {

    const { connect, createLocalTracks, createLocalVideoTrack } = require('twilio-video');

      console.log("hello video");
      const token = localMedia.dataset.token;
      const videoRoom = localMedia.dataset.room;
      const disconnet = document.getElementById('disconnect');

      connect(token, {
        audio: true,
        name: videoRoom,
        video: { width: 414 }
      }).then(room => {
        console.log(`Successfully joined a Room: ${room}`);

        const localParticipant = room.localParticipant;
        console.log(`Connected to the Room as LocalParticipant "${localParticipant.identity}"`);

        // Log any Participants already connected to the Room
        room.participants.forEach(participant => {
          console.log(`Participant "${participant.identity}" is already connected to the Room`);

           participant.tracks.forEach(track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });

          participant.on('trackAdded', track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });
        });

        // Log new Participants as they connect to the Room
        room.once('participantConnected', participant => {
          console.log(`Participant "${participant.identity}" has just connected to the Room`);


          participant.tracks.forEach(track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });

          participant.on('trackAdded', track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });

        });

        // Log Participants as they disconnect from the Room
        room.once('participantDisconnected', participant => {
          console.log(`Participant "${participant.identity}" has disconnected from the Room`);
        });

        disconnect.addEventListener('click', (event) => {
          room.disconnect();
        });


      }, error => {
        console.error(`Unable to connect to Room: ${error.message}`);
      });


      createLocalVideoTrack().then(track => {
        const localMediaContainer = document.getElementById('local-media');
        localMediaContainer.appendChild(track.attach());
      });

  }
}

export {initVideoCall};
