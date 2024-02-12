Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063963EA87
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=gyYc7QOUa3jluT3IJtYYpfEX2/EOQcmmdqh0tjxF4529e+n5u4wzB9U1nIovzyR0JwLMSMgm+ALXqjDBB063mLrFTPKOobNbSsmlBiZ5Toc8Y1Mn0ltbnGVauQTzN5+P1lOYOI4mVfApc1I1iLxy9VB76Dyh3lP7sxaUoyGYiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=SCzVm2UUC1IMA/HHo4CTYKroQfXLl7GJr3AiqyJR6Pk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XgEso/jejp7/ezSEL9k5vQKcccBbRLvoPxTa3vLBpbwV5yXe43DlgHcckHzLHYGz+W5rDMzggLNbn7Bvihuo+NfRark99Dn/d/Rqs/hb1H/wA9P9j9K0MlnPEmJjtW1Zd+JpoH/hpLIsxIyubPseWI+xXixqouP+r368tLimohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSiHiAks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSiHiAks"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89974C43390;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758585;
	bh=SCzVm2UUC1IMA/HHo4CTYKroQfXLl7GJr3AiqyJR6Pk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qSiHiAksv6YUHsyaXaUyGWCoGyelXtWza9UTlMhSBe1aZ46Tb/PdtqL3qzMPdFDHh
	 whx+bzgbXimaLQ8ogF6Io7J6K8jh1WpZzo5aj4nkStgyZcVrtHzK0DvCKm5BnYE0gL
	 iHpMkEzo6OJxyFULboq1+PxUVbECD+dGXAj5bye/gQOxZrf3HU8BKl0qNm4tGi50OH
	 k8M9WlibAv83DX7lkWbkiNnGi6CL3MEu733ioduuivlaJso9O0UA/aVVYN98qET06+
	 saXi+Myi+fExpjknpADWLurks9aUQbBaPREnyUHQBzWDA7idV/NGLK720jEL3cNNFf
	 bI50EHiJDmt7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8F7C4829E;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH kmod 00/13] Load compressed modules with compression-less
 kmod
Date: Mon, 12 Feb 2024 17:23:01 +0000
Message-Id: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVTymUC/x2LSwqAMBDFriKzttDWT8GriAu1T52FHzoggnh3R
 5chyU2CxBBqspsSThbeNwWXZzQu/TbDcFQmb31pvfMmYtzXI0G+0kx8QUxVF8EBQ7Ahkp6qf6F
 j2z3PC8My6f5lAAAA
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1821;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=SCzVm2UUC1IMA/HHo4CTYKroQfXLl7GJr3AiqyJR6Pk=;
 b=FdjIW3gR+exoID4TE8nLHlI/4/FlBTPqGOZZboJbCmKbLbkP/+/v2Dd2Xl1CwtFiaScX99Myk
 KsMVHYbGlJKAdec3gHAqiRPUyOPJSl5PMjvZk2FGZyv1fgwoRn1vrt1
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

While I was digging into a dkms bug, I've noticed that kmod does not
fallback to the normal init_module() code path when the in-kernel
decompression fails.

As I looked closer, I realised that the current module compression
detection relies on kmod being build with zstd, xz, zlib ... Even in the
case where we rely on the kernel module itself to decompress - aka we
don't use the external libraries all together.

By building kmod without zstd and friends, we shave some space off the
initrd which helps with boot time.

Majority of this series handles the latter and fixes a few related bugs
along the way. The last commits is somewhat questionable commit and
addresses the former issue.

Happy to hear your feedback,
Emil

---
Emil Velikov (13):
      libkmod: use a dup()'d fd for zlib
      libkmod: keep gzFile gzf local to load_zlib()
      libkmod: remove kmod_file::{zstd,xz}_used flags
      libkmod: clear file->memory if map fails
      libkmod: nuke struct file_ops
      libkmod: propagate {zstd,xz,zlib}_load errors
      libkmod: move kmod_file_load_contents as applicable
      libkmod: always detect the module compression
      libkmod: swap alloca usage for a few assert_cc
      libkmod: tidy-up kmod_file_open()
      libkmod: move load_reg() further up
      libkmod: keep KMOD_FILE_COMPRESSION_NONE/load_reg in comp_types
      libkmod: always fallback to do_init_module()

 libkmod/libkmod-file.c     | 206 ++++++++++++++++++---------------------------
 libkmod/libkmod-internal.h |   2 +-
 libkmod/libkmod-module.c   |   8 +-
 3 files changed, 90 insertions(+), 126 deletions(-)
---
base-commit: b29704cd448aaa455dba4e656fc0f0d3c686df3f
change-id: 20240212-decompression-fixes-56371eeb707d

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

