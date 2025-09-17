Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0330CB29;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113202; cv=none; b=fPtjU42OWuc4m1fuFjDPG9I3SEOKwvvne+I6VK2k2nsAfbe2y8eyS+LgrMsCUbVVksBYGmy/dddCKUpk5QcyQaZPDBAygEKNDXceRWfskZGnwlXeskwj+1T2zozufT89PYvtjm54ldtoITQP5jwHuoxJeTwgLrNWKyfJ6jWWPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113202; c=relaxed/simple;
	bh=7MnLSLDqHSKYhr2jX7InTUROcDbNmLJmoidtzjDWx/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=evJ7JL2y5UR0JF02doxXbk1G1o3uhVsFJYYQUjUzuh2A2Z1P9itp9SZkm97bebrnkkthHLHRqIUUb40NNsnurqDC/MJpgbZxC+rHLgnNaMOQqZjr+UfTJZqLkHO/2VEy/IHpcphJx2YJd4ZpTd1ZrlT9MwM8lIrUSZXNfxvFJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0ojVKrK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0ojVKrK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CAACC4CEF5;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113202;
	bh=7MnLSLDqHSKYhr2jX7InTUROcDbNmLJmoidtzjDWx/Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=F0ojVKrKOnPWcR+XtLMCbDgyUWV0lYqodR68zPcaIHNEVImKNX1Yi9ayxCky4GKmT
	 blJXTppvwvKZfvD0iCDEyT4s50GeBbfyKuKu3+Up9xe7ek7Q23CPBbfn0vdOuBzxdE
	 LoP0wpzPt6wxtIlmBY7DB1OLOPIgzaXvh5U6MGbzkA9Tr0PRxbRPbPa6hRPHrvMTBR
	 1nIjLYbsQKcKsJtWX2nyQZ8kznKxBIFJK1gP/73eI2EBP5Ip7GybS473gQo6V+ImBD
	 HBhvAid2LAbPZmyJRGn3YsgC7cM7Ls8FVsbdaYKhweSHmIlwL3ZkcWpyS7QcHhfJwC
	 eWI+Vx9vXLwVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A27ECAC599;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH v3 0/4] ALSA: usb-audio: add module param
 device_quirk_flags
Date: Wed, 17 Sep 2025 20:46:39 +0800
Message-Id: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+tymgC/22NzQ7CIBAGX8XsWQxs/cOT72E80GWxHAQDLdE0f
 Xdpoxfjcb7szI6QOXnOcFqNkLj47GOo0KxXQJ0JNxbeVgaUuJNaSZHjEKwwWtFxTxpta6DePhI
 7/1w6l2vlzuc+pteSLWpevwX8FIoSUhBpclY7tFKdh1B/90zdhuId5krBvyZWUyo2jcWDdtv21
 5ym6Q1dSKVy2AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113201; l=1478;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=7MnLSLDqHSKYhr2jX7InTUROcDbNmLJmoidtzjDWx/Y=;
 b=bUZz6m0RyNBnrBWVKttV3rveS6EnR5uIcNuAeRDLbzShnesdSz83xo4+h794BdwW3KEfFZ/zB
 Nb9sfgD1EaeCCLsjV22bJrgO36xplueTaGSFIWQ3re/0Mv7pXtEhcMA
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
Changes in v3:
- Instead of a new param, improve the existed one.
- Link to v2: https://lore.kernel.org/r/20250912-sound-v2-0-01ea3d279f4b@uniontech.com

Changes in v2:
- Cleaned up some internal rebase confusion, sorry for that
- Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com

---
Cryolitia PukNgae (4):
      ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
      param: export param_array related functions
      ALSA: usb-audio: add module param device_quirk_flags
      ALSA: doc: add docs about device_device_quirk_flags in snd-usb-audio

 Documentation/sound/alsa-configuration.rst | 112 ++++++++++++------
 include/linux/moduleparam.h                |   3 +
 kernel/params.c                            |   9 +-
 sound/usb/card.c                           | 177 +++++++++++++++++++++++++++--
 sound/usb/quirks.c                         | 123 +++++++++++++++++++-
 sound/usb/quirks.h                         |   5 +
 sound/usb/usbaudio.h                       |  15 +++
 7 files changed, 394 insertions(+), 50 deletions(-)
---
base-commit: 4c421c40c8b30ab7aae1edc7f7e294fcd33fc186
change-id: 20250910-sound-a91c86c92dba

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>


