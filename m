Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B742FFDDB;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187475; cv=none; b=t7qEA3bahNBIFRbVffVLrgVWxKlDMRhe9VTANumRZ9ZOIW9CVJnvGMK4XyZrUuCJ1wLSq+YwJ8c1QK5Gjcb/AbrMdF6XfFfyAo3ITAwXvkULculkLOQeSdaga3uHCIK9tccXcoTJPylu9soY9UXuC7CvlG7QGHxK6grEfax6F2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187475; c=relaxed/simple;
	bh=LGd4NE5xucIBmY8TEZN2nv2o/wj6Qe3DoMkc6uy1Dow=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cplvLqaQOynymCD1tKkSlSzBXCk3H1UeMWTkJ5L6oeXIbyhe0Wlutw/UrzsY/D2o3T2ksoPJj4cGaJJIRey76cOuSAsye8kfQqSXJ/O1eVX/doioIg1/ygElISHL7mfCxUUpKKH8abrVon8SQascw6SbyWORXEX4fwdwODIU5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqPEfk50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqPEfk50"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD87C4CEE7;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758187475;
	bh=LGd4NE5xucIBmY8TEZN2nv2o/wj6Qe3DoMkc6uy1Dow=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BqPEfk50DVBTf887LhVDzmEYLLhmkP6TMPB27PHynolPG4Y4Q2w+i+NG2zrZ650kh
	 QK3cH/74bOfC3mymgnadBnCiFGAfRGORHEAxslQ+Q3rs6EtdvGdSCC7IalLn5VT+uZ
	 kWX71tMTHGLQ2R3+MPQ97pxcEWwfCKdIVr7EjxKX8V8rMDkauF2kKtTlY+G/J+E8J7
	 nIteoskJEFwRPa6D1kOUg2KnEYs3GidzPBfQF0c9/nPikiC6LnhbW5nZw+8SM5dSaF
	 WIGvwF5zRIStTUfAZtB5MERxGG60NxO71L4DwAGAVL2ENYXqDPRB21Ue7iy/ONupV4
	 z9LFm+whUlJ5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DCECAC597;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH v4 0/5] ALSA: usb-audio: add module param
 device_quirk_flags
Date: Thu, 18 Sep 2025 17:24:29 +0800
Message-Id: <20250918-sound-v4-0-82cf8123d61c@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM3Py2gC/23NQQ7CIBCF4as0rMXAtFrHlfcwLigMloXUQEs0T
 e8ubWxiTJdvwvczskjBUWTnYmSBkouu83lUu4LpVvk7cWfyZiDgIFAKHrvBG65Q6tNRI5hGsfz
 2Gci619K53vJuXey78F6ySc7XtQDfQpJccK1RW4MWjJCXwee/e9LtXncPNlcSbErIUkhSpYEab
 dVsyfJX1qsss0SghrCqQQn1L6dp+gB1mO8YEgEAAA==
X-Change-ID: 20250910-sound-a91c86c92dba
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
 Cryolitia PukNgae <cryolitia@uniontech.com>, Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758187473; l=1700;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=LGd4NE5xucIBmY8TEZN2nv2o/wj6Qe3DoMkc6uy1Dow=;
 b=o2HzUJjj8jUfJ9woKChJmX3gWxj5JbpwyEU3iaRqY0FfnwX6uiBX0fHNdH+fF0E5nfcvHmLBS
 xu/wmAobUA0AZ7u5RdI2TJTlv9etPSjZ1pwL/8DdYCs3vLImHdcDw4m
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

As an implementation of what has been discussed previously[1].

1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
Changes in v4:
- Split basic parse and dynamic change
- Drop usage of linked list
- Link to v3: https://lore.kernel.org/r/20250917-sound-v3-0-92ebe9472a0a@uniontech.com

Changes in v3:
- Instead of a new param, improve the existed one.
- Link to v2: https://lore.kernel.org/r/20250912-sound-v2-0-01ea3d279f4b@uniontech.com

Changes in v2:
- Cleaned up some internal rebase confusion, sorry for that
- Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com

---
Cryolitia PukNgae (5):
      ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
      param: export param_array related functions
      ALSA: usb-audio: improve module param quirk_flags
      ALSA: usb-audio: make param quirk_flags change-able in runtime
      ALSA: doc: add docs about improved quirk_flags in snd-usb-audio

 Documentation/sound/alsa-configuration.rst | 108 ++++++++++-----
 include/linux/moduleparam.h                |   3 +
 kernel/params.c                            |   9 +-
 sound/usb/card.c                           |  63 ++++++++-
 sound/usb/quirks.c                         | 206 ++++++++++++++++++++++++++++-
 sound/usb/quirks.h                         |   6 +-
 sound/usb/usbaudio.h                       |   6 +
 7 files changed, 352 insertions(+), 49 deletions(-)
---
base-commit: 4c421c40c8b30ab7aae1edc7f7e294fcd33fc186
change-id: 20250910-sound-a91c86c92dba

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>


