Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AE426D2D
	for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835507; cv=none; b=B+KpjniFi7IRKns82nw0IWbwR0e/aaV92HHiqBMNA5Mcc8GR1LQiWBlwb9Dhi66l6TAqTPIPSOedg1YeRHjCJWBmV5KNWAkCOgsKUw17gcjQX5zA5IerPIcnE6pgUpsYEXiCWKSaGLo0r7vw7HI3o/VKt9BecJfE5Z3KXqAbQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835507; c=relaxed/simple;
	bh=DpvFIVIZ1tKrtWFxiFTVbPPLSCZ0en//NG1n+cRrz7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RXmcDvV1ktt65GAuGDU55LHZDTVSQlWQhn6te8BOpa902IFkmqrhcAeMU7dHvaMmMqiEecauxhXL2a6c0cPDKmEIIUp/pTPTmH0wG9hnesrNTOvlbElOlAwq6OCX6TVrMFNWYuruDj1N7U/HniAl66vydCJOWJY0bVpxL/leQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu1TFt3j; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu1TFt3j"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so7805530f8f.0
        for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835505; x=1779440305; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/wqiPCT0YPI0qW/S/HjDfZIvr2fAKk25WVI+QsyRLU=;
        b=lu1TFt3jFJAr69OsE0Eswzb6yQhiw6jPt5rhSG5X9W/kklg09kZg51UlfWMXrNmxtH
         Aw+t8dnmvpj1z6xqvdwbhuxLujH7q0zbdT6Da2bR+6CrSBczvnJ/M7VidrBq9BYsIeMt
         zd4/mYLqqOBKl/Of1P7pTT9bEMG9LwtymPHejYPa9QF3vWqVk1Bd7HRdw+1w59kfu8XY
         Pevii3A19PjU7KXF1DpHJnnffHk0XMODH5y9/xk6eQBrurYZpRd9bYYVq92owdKU7Or0
         APqc39F0X586dpv5ymyHKtL76A0RwT4fPAZW9E0RTcvLVj5B5UxhF9dMD4I5idOgCmZw
         U4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835505; x=1779440305;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/wqiPCT0YPI0qW/S/HjDfZIvr2fAKk25WVI+QsyRLU=;
        b=Hx+iCCVa2N+QZo//e+eftDwUkoNav6D8vyY72xuN7c88oVkZCchqZa7SDVWw1Taxv+
         UySudW7LuoZFMj/8fU4kCKEaXCgGNBOQJosb4+wS/lnXmZjMCyCYKRsWws3LKELcrN1F
         N7jX7kBOkunbi3iZ8kWe3k23+zcN4b10JeyPiN+lgDyCPU/l5fC0jubWi7CyWt3JSBh/
         FCIhB8O81MUARTeInsh/upZxIfc42BfyHAVV5Scwc6xc+o/OIL65/Kq/3NP9KQ1+obgy
         VPi/NzKaI5vW+e2clLo43Yu5vpr0rSzqmwKkPyBrB1+DvVbCPBl+1Y+uD5ropw3Bv+/P
         tnKg==
X-Forwarded-Encrypted: i=1; AFNElJ9sgdGRI6td7SHcVBgrQldrzSd6Fi/hmsbN0SNSvqRHzMXpUsv2hJgCw1+1N0iuPDtP7NX5mRsPMnrTa1qL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76sBipq84f8yKI8qdFOoZvvhM4wrtdZbn4gREu6yWGTpSl8fg
	wLApuQ6lDBpXpf+LMegkhfD1S6hYki0vWf+MCdssfEppR5BzU8NasTKK
X-Gm-Gg: Acq92OEvN1/N9t92pNys4cuaWpu+mNpn11hUFHDGg/rNWbqI8qDsGK4AZn5M3P2Koq0
	wsUTrKyQaIDnGevGTT3xG2cBvn974znnfJA5m6OXFyxypz2k1F4NKLYLslxZjrpWyj/tiCNSuU8
	0HezrOd6gFs2DvdaEO35VG4/ZPipdRCJaTE9eytzgs4/IM6Ko/wD2THexYXBfCStT1c1xRbZ5TW
	mKB6nNl1wSPJhF8DyFEE510H9eLJ8SrjndmMrqXbhFnC2mPsD72KuVnK4pW++9FOVfxFhIms3KT
	twGQm0APu00RZXNfQ3+hDYzKtdMipOqzx3OIAmwKPv1AoeSOBVPzkZwSWMQfw+QWe66SybLUlfI
	EpVmgB2I5foFkAW7m83Ks0Mt4Cxc4VpkxHSrlFPN9I282dUPI/xcmwsvFSGjVkru3hTiGeQnV7q
	4+Fp4dUfei+H9uqUquYcHkrB41tuvV02D2pcqbgiq+5xg=
X-Received: by 2002:a05:6000:3108:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-45e5c5874e3mr3808053f8f.27.1778835504446;
        Fri, 15 May 2026 01:58:24 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 0/5] dyndbg: fix i386 alignment and KEEP module sections
Date: Fri, 15 May 2026 02:58:09 -0600
Message-Id: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMywqDMBCF4VeRWXdKMjFqu+p7lC5CMmqgXkhKa
 BHfvdGVFLo8B75/gcjBc4RrsUDg5KOfxjzUqQDbm7Fj9C5vIEGV0ILQxAE7HrOyKFGRbUoySjs
 nIJs5cOvfe+/+yLv38TWFz55Pcnv/lZJEgVIKxSykJtfeusH459lOA2ylREdd/2rKuqytplpfH
 FXNUa/r+gXBfPbM6AAAAA==
X-Change-ID: 20260502-asm-generic-1-32c842a35dd0
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=2729;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=DpvFIVIZ1tKrtWFxiFTVbPPLSCZ0en//NG1n+cRrz7w=;
 b=Ui9msCCEx+Ir7Hz8Ovx6hpfNqXShEbOJmFFaKRmm0uhdl3Bk9K/rqlNt/k2Xgk/B05Ip9zVII
 I/hO7sAZ13BDeSwmmAbSfGeZG0juxaDfOoXlhPA71xQJ1zK/LFcw+af
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This series starts with a fix to a section misalignement on i386, and
follows with cleanups and refactoring for reuse.

When CONFIG_DRM_USE_DYNAMIC_DEBUG=Y (currently marked BROKEN) and
CONFIG_DRM=y, the __dyndbg_classes section gets a single
struct/record.  On i386 this is 28-bytes, breaking the required
ALIGN(8) on the following __dyndbg section.

This breaks dynamic_debug_init() with a NULL pointer dereference; the
section traversal logic encounters padding bytes instead of a valid
descriptor.

the series:

1. refactors BOUNDED_SECTION_* macros for later reuse
   v2- adds note that macros are for vmlinux.lds.h only, not for modules.

2. drops unused HEADERED_SECTION_* macros

3. fixes ALIGN(8) omission causing NULL ptr on i386
   adds,uses BOUNDED_SECTION _ALIGNED variants

4. removes now redundant ALIGN(8)s in vmlinux.lds.h

5. adds dyndbg.lds.S to KEEP sections in modules
   follows codetag.lds.h model

v3:

move #includes to top of files,
drop redundant ALIGN(8) in dydnbg.lds.S: DYNDBG_SECTIONS macro
add Reviewed-by tag (thx Petr)

v2:

- avoids BOUNDED_SECTION in modules.  Since ELF sections have well
  defined bounaries, _start & _end symbols are useless, and empty
  sections are unhelpful, possibly confusing to tools.

- sets 0 address to the sections, not just whatever current is.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20260507-asm-generic-1-v2-0-47c52759d268@gmail.com

Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com

---
Jim Cromie (5):
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.S: fix lost dyndbg sections in modules

 MAINTAINERS                                |  1 +
 include/asm-generic/bounded_sections.lds.h | 32 ++++++++++++++++
 include/asm-generic/dyndbg.lds.h           | 18 +++++++++
 include/asm-generic/vmlinux.lds.h          | 59 ++++--------------------------
 scripts/module.lds.S                       |  2 +
 5 files changed, 61 insertions(+), 51 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260502-asm-generic-1-32c842a35dd0

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

