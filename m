Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6931A812;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113203; cv=none; b=te8EmfMpjKWdVWMcmKzGMoQeJC5fPP+pEmTcfGNhOFSNmpKda7x6JqqDFOSQMH9Krw84InRIiM540LBpdk7Wkea70UICEKwlQYslTgM1vh5d/NAQlQVear58ifk6WKIoIaH27aTT+lwNmH8gnAOb3kIS1io3tQj9EHJda5piX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113203; c=relaxed/simple;
	bh=4m09HVxeWOmfLkoOABM2Z8FAF12xRU3thrbn9gHjaNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1kNISI/iTc0/Jv0HIH5lnCJh9GUZPIBpjoUtMCq8H4DmqRp4jpHAObX08j6oZOB/H8pMS+AA/JfNJlFso49AXbUT1CT0KXTcnJ/weeiTABrzrRmjUX3fWVD8ayHAWPl2KKz6cTl63QAqcEoEtonDXHtGP7ZaHgApsdr8SnogVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3Uy6JTX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3Uy6JTX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D12B3C113D0;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113202;
	bh=4m09HVxeWOmfLkoOABM2Z8FAF12xRU3thrbn9gHjaNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T3Uy6JTXmXOdWE1jCViAWmbalx94XMPubKal1ngWRnwRZQxn6OHyjSbdLB55wDegq
	 kwchp2jtqAgCLwibxdJkjtvSqeecNCkH2SpvfIeIuRJIykV9vaukIyeD4EJtwslAnO
	 pP+RLtBLQqWYYZ7PEA7+8xXnOTIqBUt8jK2xZEOu9HAslESlIYyn8w2dgP6rzsdeaj
	 B45/r22U1wKIajoKPQ98QtyzkDbbgiZXJA1Lwxn+cKmx5xwzWTzntn4V8KlLtYgKEq
	 teRsCETM/VFkarkjmGp+7NDu0VRFkkIf/VPqCO+LklYwDn80uH0/f8VMYOzrwBx+X5
	 Vd+nIwH5l6mmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8511CAC59D;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 17 Sep 2025 20:46:43 +0800
Subject: [PATCH v3 4/4] ALSA: doc: add docs about device_device_quirk_flags
 in snd-usb-audio
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sound-v3-4-92ebe9472a0a@uniontech.com>
References: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
In-Reply-To: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>
Cc: linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, linux-modules@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113201; l=7243;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=FrGLJBJnqo9zN6+xgDNO+WYVjRiKsb3cKaYsHmjiH7E=;
 b=gE/1lcbGSKLIyPWnGhSWN9s4EGeSj22aOYnwzSYGBlHiz/h4eoEflKVPMBXlJbVITGCM5tsKK
 2SPYbCo7t7dB5hFGmA2W+zwcRfvQsES/Bs2Y7C1hW+2eqgK2UiC7rOs
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Just briefly described about the new option.

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 Documentation/sound/alsa-configuration.rst | 112 ++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 35 deletions(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index a2fb8ed251dd0294e7a62209ca15d5c32c6adfae..23ee37f24ff89a983b3dffe6312057cd84b8f579 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2297,39 +2297,81 @@ skip_validation
     of the unit descriptor instead of a driver probe error, so that we
     can check its details.
 quirk_flags
-    Contains the bit flags for various device specific workarounds.
-    Applied to the corresponding card index.
-
-        * bit 0: Skip reading sample rate for devices
-        * bit 1: Create Media Controller API entries
-        * bit 2: Allow alignment on audio sub-slot at transfer
-        * bit 3: Add length specifier to transfers
-        * bit 4: Start playback stream at first in implement feedback mode
-        * bit 5: Skip clock selector setup
-        * bit 6: Ignore errors from clock source search
-        * bit 7: Indicates ITF-USB DSD based DACs
-        * bit 8: Add a delay of 20ms at each control message handling
-        * bit 9: Add a delay of 1-2ms at each control message handling
-        * bit 10: Add a delay of 5-6ms at each control message handling
-        * bit 11: Add a delay of 50ms at each interface setup
-        * bit 12: Perform sample rate validations at probe
-        * bit 13: Disable runtime PM autosuspend
-        * bit 14: Ignore errors for mixer access
-        * bit 15: Support generic DSD raw U32_BE format
-        * bit 16: Set up the interface at first like UAC1
-        * bit 17: Apply the generic implicit feedback sync mode
-        * bit 18: Don't apply implicit feedback sync mode
-        * bit 19: Don't closed interface during setting sample rate
-        * bit 20: Force an interface reset whenever stopping & restarting
-          a stream
-        * bit 21: Do not set PCM rate (frequency) when only one rate is
-          available for the given endpoint.
-        * bit 22: Set the fixed resolution 16 for Mic Capture Volume
-        * bit 23: Set the fixed resolution 384 for Mic Capture Volume
-        * bit 24: Set minimum volume control value as mute for devices
-          where the lowest playback value represents muted state instead
-          of minimum audible volume
-        * bit 25: Be similar to bit 24 but for capture streams
+    The option provides a refined and flexible control for applying quirk
+    flags.  It allows to specify the quirk flags for each device, and could
+    be modified dynamically via sysfs.
+    The old usage accepts an array of integers, each of which apply quirk
+    flags on the device in the order of probing.
+    e.g. ``quirk_flags=0x01,0x02`` applies get_sample_rate to the first
+    device, and share_media_device to the second device.
+    The new usage accepts a string in the format of
+    ``VID1:PID1:FLAGS1;VID2:PID2:FLAGS2;...``, where ``VIDx`` and ``PIDx``
+    specify the device, and ``FLAGSx`` specify the flags to be applied.
+    ``VIDx`` and ``PIDx`` are 4-digit hexadecimal numbers, and could be
+    specified as ``*`` to match any value.  ``FLAGSx`` could be a set of
+    flags given by name, separated by ``|``, or a hexadecimal number
+    representing the bit flags.  The available flag names are listed above.
+    An exclamation mark could be prefixed to a flag name to negate the flag.
+    For example, ``1234:abcd:mixer_playback_min_mute|!ignore_ctl_error;*:*:0x01;``
+    applies the ``mixer_playback_min_mute`` flag and clears the
+    ``ignore_ctl_error`` flag for the device 1234:abcd, and applies the
+    ``skip_sample_rate`` flag for all devices.
+
+        * bit 0: ``get_sample_rate``
+          Skip reading sample rate for devices
+        * bit 1: ``share_media_device``
+          Create Media Controller API entries
+        * bit 2: ``align_transfer``
+          Allow alignment on audio sub-slot at transfer
+        * bit 3: ``tx_length``
+          Add length specifier to transfers
+        * bit 4: ``playback_first``
+          Start playback stream at first in implement feedback mode
+        * bit 5: ``skip_clock_selector``
+          Skip clock selector setup
+        * bit 6: ``ignore_clock_source``
+          Ignore errors from clock source search
+        * bit 7: ``itf_usb_dsd_dac``
+          Indicates ITF-USB DSD based DACs
+        * bit 8: ``ctl_msg_delay``
+          Add a delay of 20ms at each control message handling
+        * bit 9: ``ctl_msg_delay_1m``
+          Add a delay of 1-2ms at each control message handling
+        * bit 10: ``ctl_msg_delay_5m``
+          Add a delay of 5-6ms at each control message handling
+        * bit 11: ``iface_delay``
+          Add a delay of 50ms at each interface setup
+        * bit 12: ``validate_rates``
+          Perform sample rate validations at probe
+        * bit 13: ``disable_autosuspend``
+          Disable runtime PM autosuspend
+        * bit 14: ``ignore_ctl_error``
+          Ignore errors for mixer access
+        * bit 15: ``dsd_raw``
+          Support generic DSD raw U32_BE format
+        * bit 16: ``set_iface_first``
+          Set up the interface at first like UAC1
+        * bit 17: ``generic_implicit_fb``
+          Apply the generic implicit feedback sync mode
+        * bit 18: ``skip_implicit_fb``
+          Don't apply implicit feedback sync mode
+        * bit 19: ``iface_skip_close``
+          Don't closed interface during setting sample rate
+        * bit 20: ``force_iface_reset``
+          Force an interface reset whenever stopping & restarting a stream
+        * bit 21: ``fixed_rate``
+          Do not set PCM rate (frequency) when only one rate is available
+          for the given endpoint
+        * bit 22: ``mic_res_16``
+          Set the fixed resolution 16 for Mic Capture Volume
+        * bit 23: ``mic_res_384``
+          Set the fixed resolution 384 for Mic Capture Volume
+        * bit 24: ``mixer_playback_min_mute``
+          Set minimum volume control value as mute for devices where the
+          lowest playback value represents muted state instead of minimum
+          audible volume
+        * bit 25: ``mixer_capture_min_mute``
+          Be similar to bit 24 but for capture streams
 
 This module supports multiple devices, autoprobe and hotplugging.
 
@@ -2344,8 +2386,8 @@ report it to the upstream.
 NB: ``quirk_alias`` option is provided only for testing / development.
 If you want to have a proper support, contact to upstream for
 adding the matching quirk in the driver code statically.
-Ditto for ``quirk_flags``.  If a device is known to require specific
-workarounds, please report to the upstream.
+Ditto for ``quirk_flags``.  If a device
+is known to require specific workarounds, please report to the upstream.
 
 Module snd-usb-caiaq
 --------------------

-- 
2.51.0


