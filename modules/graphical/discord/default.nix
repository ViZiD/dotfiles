{
  inputs,
  config,
  lib,
  # pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.discord;
  isPersistEnabled = config.dots.shared.persist.enable;
  # isStylesEnabled = config.dots.styles.enable;
  user = config.dots.user;
in
{
  options.dots.graphical.discord.enable = mkEnableOption "Enable discord";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      imports = [ inputs.nixcord.homeModules.nixcord ];

      # stylix.targets = mkIf isStylesEnabled { nixcord.enable = true; };

      programs.nixcord = {
        enable = true;
        discord = {
          enable = true;
          openASAR.enable = true;
        };
        # vesktop.enable = true;
        config = {
          plugins = {
            alwaysAnimate.enable = false;
            alwaysTrust.enable = true;
            anonymiseFileNames = {
              enable = true;
              anonymiseByDefault = true;
            };
            betterSettings.enable = true;
            betterUploadButton.enable = true;
            clearURLs.enable = true;
            copyFileContents.enable = true;
            copyUserURLs.enable = true;
            disableCallIdle.enable = true;
            dontRoundMyTimestamps.enable = true;
            fakeNitro.enable = true;
            fixSpotifyEmbeds.enable = true;
            fixYoutubeEmbeds.enable = true;
            friendInvites.enable = true;
            # hideAttachments.enable = true;
            imageZoom.enable = true;
            implicitRelationships.enable = true;
            noF1.enable = true;
            noOnboardingDelay.enable = true;
            noTypingAnimation.enable = true;
            noUnblockToJump.enable = true;
            openInApp.enable = true;
            permissionFreeWill.enable = true;
            permissionsViewer.enable = true;
            platformIndicators.enable = true;
            readAllNotificationsButton.enable = true;
            replyTimestamp.enable = true;
            showHiddenChannels.enable = true;
            showMeYourName.enable = true;
            silentTyping.enable = true;
            spotifyShareCommands.enable = true;
            userVoiceShow.enable = true;
            voiceMessages.enable = true;
            volumeBooster.enable = true;
            youtubeAdblock.enable = true;
            webScreenShareFixes.enable = true;
            fixImagesQuality.enable = true;
            forceOwnerCrown.enable = true;
            gameActivityToggle.enable = true;
            newGuildSettings.enable = true;
            notificationVolume = {
              enable = true;
              notificationVolume = 100.0;
            };
            translate.enable = true;
            streamerModeOnStream.enable = true;
            validUser.enable = true;
            validReply.enable = true;
            silentMessageToggle.enable = true;
            serverInfo.enable = true;
            quickMention.enable = true;
            noMosaic.enable = true;
            memberCount.enable = true;
          };
        };
      };
    };

    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        # ".config/vesktop"
        ".config/discord"
      ];
    };
  };
}
