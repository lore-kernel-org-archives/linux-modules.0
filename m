Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51890137756
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=PwuwnsQif1tZGNiLHTm8u7nkcQq7IRuzgA/p7+Io3vurlPJfycdIs20RZMpZ8o9dZfGG9S9cDXsw3mYs/mHyHKYqX3DL3sOWMo6wMofC6WPBP3DC485MzXoC4c1a3su4DTgumDRrCBlagDkuNmxUFfYecMZPhaX1dwwUOM1j2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=+Xy7sIFsLWX8oDHDml1nqxSfzsgAHAICJCGlyTYQN0s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E5kgLa22BVyMfXcFkw0PW0EDYWjTJbE8jpKFW7xX71aXtBiexLFbm4CFnP/PF3Dj54DfHh8xfgipVb+QraLoAyj46JcxQrKyuTMvWdgZzBzFwSZ/dsBVX1auHFeaSsTk+7vUKw1bZjKyMaSztsen6FqdkEDE1YtO/g+RjcDPDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUQZoVap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUQZoVap"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA88C116B1;
	Mon,  8 Jul 2024 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=+Xy7sIFsLWX8oDHDml1nqxSfzsgAHAICJCGlyTYQN0s=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QUQZoVapKrCOmsmVoPCUr0ugS+h/EllrUw4siXGeV4fGWsQcdchJLSaNUxyD1pH7N
	 aUahmk4QUUdSIhTqjM2R8OM+5z9NwXiWtgkhvNLPHA0kf9IexrEfzEt82FTvoqBM/L
	 9rdBMLB6f753VfRYQ8BiOfI0T44crhO8M6pTkAkHkAe5NdWv6YPkf0IIraZXGrUAcy
	 P0hdD5yKTxOYGmryWzrO3UPvLUGfRnq9thCHYZm52D7ZJi8oyjhWwVJm+2QlIJsN4F
	 mO8n97Iiu9TjbS4TNWeogbBCP2GAX2xOp/2HuD/XHDIBxfwHEdnn7iAF2f4r1y1dys
	 pl5mgGYSNjZLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A49C3DA42;
	Mon,  8 Jul 2024 13:43:31 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH kmod v2 00/17] man: minor improvements, post the scdoc
 conversion
Date: Mon, 08 Jul 2024 14:43:08 +0100
Message-Id: <20240708-man-v2-0-a23df6ef871e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzsi2YC/yWMyw6CMBBFf4XM2pq+qOLK/zAsCh1gEqGkNY2G9
 N+tdXlu7jkHRAyEEW7NAQETRfJbAXlqYFzsNiMjVxgkl5q3UrHVbuyilTPYChzMBOW5B5zoXSu
 PvvBC8eXDp0aT+K1/3whR/SQYZ4MzV6Od7ozq7vNq6Xke/Qp9zvkLjKTX6JYAAAA=
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=2650;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=+Xy7sIFsLWX8oDHDml1nqxSfzsgAHAICJCGlyTYQN0s=;
 b=1M7eGaaTMBZxtlZoqGpKD2DlWHIHsOSFWf+sJ0m962CHNhPhC/HoiZjwBSbt82y7lv3WQSha7
 WThxKosKPAWDDvxtL8FJvhXawo1s2d5Cty+jNdsyIedlFRHhgUnDhmE
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

Hello all,

Here is the remaining patches from my scdoc series, re-spinned with all
(:fingers-crossed:) the comments addressed.

The series includes:
 - patch 1-5 - trivial fixes as white space, punctuation, etc
 - patch 6-14 - expand documentation around {depmod,modprobe}.d
   handling, remove open-coded .d and .conf references
 - patch 15 - remove "maintained by" references
 - patch 16 - NEW: replace all AUTHORS sections with suggested snippet
 - patch 17 - list short and long options on separate lines

Note that make distcheck has regressed on the master branch, seemingly
due to the recent weakdep test.

---
Changes in v2:

- move extra bold annotation to correct patch - 2 -> 1
- reword the configuration directories section as suggested - 7, 11
- tweak MODPROBE_OPTIONS wording - 13
- add extra patch to rework the AUTHORS section as suggested - 16

- Link to v1: https://lore.kernel.org/r/20240611-man-v1-0-bd6864d49639@gmail.com

---
Emil Velikov (17):
      man: add some extra bold/italic annotations
      man: white space fixes
      man: misc punctuation fixes
      man: some options take an argument, mention that
      man: couple of grammar/language fixes
      man: stop removing DISTCONFDIR lines
      man: depmod.d: document the config file order handling
      man: depmod.d: factor out a CONFIGURATION FORMAT section
      man: depmod.d: rework the opening description sentence
      man: depmod: remove hard-coded /etc/depmod.d references
      man: modprobe.d: document the config file order handling
      man: modprobe.d: factor out a CONFIGURATION FORMAT section
      man: add few mentions about MODPROBE_OPTIONS
      man: modprobe: remove hard-coded /etc/modprobe.d references
      man: remove the "Maintained by" references
      man: rework AUTHORS section
      man: list options one per line

 man/Makefile.am       |   8 ++--
 man/depmod.8.scd      |  78 ++++++++++++++++++++----------------
 man/depmod.d.5.scd    |  61 +++++++++++++++++-----------
 man/insmod.8.scd      |  11 +++---
 man/kmod.8.scd        |  24 +++++++----
 man/lsmod.8.scd       |  13 +++---
 man/modinfo.8.scd     |  38 +++++++++++-------
 man/modprobe.8.scd    | 107 +++++++++++++++++++++++++++++---------------------
 man/modprobe.d.5.scd  |  61 +++++++++++++++++-----------
 man/modules.dep.5.scd |  22 ++++++-----
 man/rmmod.8.scd       |  25 +++++++-----
 11 files changed, 268 insertions(+), 180 deletions(-)
---
base-commit: fa715f8c8b78a09f47701ce1cf46e9b67a49b8d0
change-id: 20240523-man-743d6e51eb6f

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>


