function initVideoCall(){

  const localMedia = document.getElementById('local-media');

  if (localMedia) {

    const { connect, createLocalTracks, createLocalVideoTrack } = require('twilio-video');

      console.log("hello video");
      const token = localMedia.dataset.token;
      const videoRoom = localMedia.dataset.room;
      const disconnect = document.getElementById('disconnect');

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
        room.on('participantConnected', participant => {
          console.log(`Participant "${participant.identity}" has just connected to the Room`);


          participant.tracks.forEach(track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });

          participant.on('trackAdded', track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });

        });

        // Log Participants as they disconnect from the Room
        room.on('participantDisconnected', participant => {
          console.log(`Participant "${participant.identity}" has disconnected from the Room`);
        });


        room.once('disconnected', room => {
          // Detach the local media elements
          room.localParticipant.tracks.forEach(track => {
            const attachedElements = track.detach();
            attachedElements.forEach(element => element.remove());
            console.log("call finnished");
          });
        });


        disconnect.addEventListener('click', (event) => {
          console.log("Hello from EventListener");
          if (confirm("Do you really want to end this videocall?")) {
            room.disconnect();
          } else {
            event.preventDefault();
          }
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
