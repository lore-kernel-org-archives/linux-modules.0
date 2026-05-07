Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90C2F8E83
	for <linux-modules@vger.kernel.org>; Thu,  7 May 2026 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186414; cv=none; b=dzF2yJ0xbnOyjaOQAEBRvZZM/FvbWtn4Yo1toZqUsiRApa8x1toL92Iwt4c5L5mM16YDXkCV2RgPr7HeuxyIguE4zgQLkzmbLgdZFqcBhXUTqjdloFr6T/M1o3p4dX1rZolRkD+h4qcuFtzKmfcRDDjNDTC1VnXxPdLSUetfx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186414; c=relaxed/simple;
	bh=gQvYJBSMH82J0Qx+KRQCR5zO/TwS8W1b0AEk5rgkF/k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qxVGTxEi9Tlt1NOKBIxjVph27+zST16//a72CRlUOeG1J4YQBJUTmHybkw5+m1ywuSP4IQZuk/2Cz5HxVQedx+kb0e/17XvctLWHVds/VoD14z7pVd+Q3RX0e6WgbCkBQncex41U4OsJ1qBkyr4X9uo3pG2xY8f8wHm1o13kvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6a7PTQb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6a7PTQb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so8964675e9.1
        for <linux-modules@vger.kernel.org>; Thu, 07 May 2026 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778186411; x=1778791211; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63VW6+hOO9ePEnkRgW9UZHav6uvJEonOy9huiUNMuWY=;
        b=n6a7PTQbAE8awV0LVkYzM68mZKRXqaFIUNDeETooWvHraAmWU5XDSW60A79MTH/vuW
         DwRhMCWS37Nmqw8kZcF6qJ5IqBV90p86Ucrdz5EAoLjmNlGEJnJS8sHFq0PTIklA93yx
         kHyplJarlwWK+Qea061GhnPVC9fErcVWNwRZkWqukJ+s1XdwEfKlT1l96rzjWVW+2jCJ
         HpjwSR7AMYqZOjeoQi+865niJcPEnGtTdbrpgUlUotRGHvpNvFiDyf5SrbVcDdylxSpI
         6cxNR5e/OiG08AWnZl/L3SuGyPmxbamnjVqbsaIvjLxdXxNdc4PiVstzfPeMc2arODxy
         Zs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186411; x=1778791211;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63VW6+hOO9ePEnkRgW9UZHav6uvJEonOy9huiUNMuWY=;
        b=dhHmykNhM4LQc9kO/jYiBgbvefPv/v8bC8uGW+i6NAy+wIoUM1VDKtAQrvXBuHAcQr
         JuBaCoQmbX+Gfx0mzDjx9DU0BoPQMdoY+tbuXLZymlQJ79p/e2ljryaY3/fEzqaUM0cQ
         pkZVD78FDL1E/rU4/aig+cdluNy3oMqylyfoVkjH99vZISh6P8WTL3aNvSsAN9uwpTwt
         1G8iXHYf6eUZMskHKzFZdMhBVte4w26tEFhJOYhZI1Y2YbboSoyn21E0ZWqWrf4p3MsZ
         CehDmpWIIASZHXr/7OQjgM9MgbsQvt2snpN5976T82ZwPWjemeB7gAtfUoQArPKNrhcc
         5UaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fuPXtyZBQXetqp6nCY20T0wtoTeVxHvmpJxugsGLEUD0+wIkP/tUsVN1Hxi9uzgdO0eRDi2fFyZWbetI8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Ur72EY/Mrt6dXSaGZfyEtjoVe5q7Wj9pDwKwrhh+0gdv1nUZ
	dkVNL63sKqma1lwc3KiLnGMNSSurzb/ppdUu6UcvBYvO5lKpnWW7tU6L
X-Gm-Gg: AeBDiesOo/e52222+l71GebS5TCUQSA05Bn9m7uojJMi3MqGJPRsuOz6uo5P5Ul9EIh
	F7SQCioNF3lnHsNf8+Lou79ZeUrCuCqDmHWt1deJammiRmdADxg6fpCQ+pabK7vtSMqHDF0PSr5
	ZyHF6bS74URJXVnjX+e77FPDXsHRPiuCskW1Qac1y8NepEzXpJGX8TCHsXcF8APTL85ZfQze0vA
	5uBmafLjuES4YPACiuP9kzwXawiZTfNJVldvhm34/Fz1cXOBAClxsBvxXtCmIOAGwdd/E2i74Fy
	K7UUwKrbjYUXhkuVHVqGdQM/PHYGm3qQ9M8vKJ4MVrfOv5bSxQewULf9x10ahUuIdflKk14tGLY
	2IiVgJWZXlRM05uVFRzQ1O0LpWLCVAYNE0bl/vAO/0u8EVf7hTnvs2W5uiCOqXhbKh5GTbCCuXz
	NWy4wBCalqs4J1+slc9NGFdHTgFTXFKUK8rmOi3mg=
X-Received: by 2002:a05:600c:32af:b0:48a:534a:eed8 with SMTP id 5b1f17b1804b1-48e5dfcd722mr41831655e9.1.1778186410767;
        Thu, 07 May 2026 13:40:10 -0700 (PDT)
Received: from [100.82.231.29] ([185.57.101.106])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm264367515e9.0.2026.05.07.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:40:10 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 0/5] dyndbg: fix i386 alignment and KEEP module sections
Date: Thu, 07 May 2026 14:40:04 -0600
Message-Id: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQrCMBAAv1L27Mpma0U8+Q/pISTbdsEmkkhQS
 v5u7N3jDMxskCWpZLh2GyQpmjWGBnzowC02zILqGwMTn2kgRptXnCW0yqHBnt3lxLYfvCdozTP
 JpO/9dx8bL5pfMX32fTE/++9UDBIaQ70ImYH9dJtXq4+jiyuMtdYva0ylxaoAAAA=
X-Change-ID: 20260502-asm-generic-1-32c842a35dd0
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778186409; l=2375;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gQvYJBSMH82J0Qx+KRQCR5zO/TwS8W1b0AEk5rgkF/k=;
 b=T8bQDcgypsv3NtypKaeDydBAHh3bMlIaEUkjYuHp20fo/uBWpC/ZRbY0NRRq5ksrbsrrCshBK
 iai5w6ZxGjZDGK/6q9vzRy4Px/OApnbl9+AZKiZ1m0Ni6F/d+9FDlcs
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

v2:

- avoids BOUNDED_SECTION in modules.  Since ELF sections have well
  defined bounaries, _start & _end symbols are useless, and empty
  sections are unhelpful, possibly confusing to tools.

- sets 0 address to the sections, not just whatever current is.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
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
 include/asm-generic/bounded_sections.lds.h | 32 +++++++++++++++++
 include/asm-generic/dyndbg.lds.h           | 19 ++++++++++
 include/asm-generic/vmlinux.lds.h          | 58 +++++-------------------------
 scripts/module.lds.S                       |  2 ++
 5 files changed, 62 insertions(+), 50 deletions(-)
---
base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
change-id: 20260502-asm-generic-1-32c842a35dd0

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

