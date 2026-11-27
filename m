Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795737626;
	b=n/ua2Np5rSotNH+keSqFyYAARoNfjuwwzKRki5Dtj5wnbvdVSYMlq7SsGKWczS/Oekug
	 rmqfClCywIyWQFULbQ5NMBZWH56Ny47Z49O6VEdqRFiPBf17+6BMnzV/jM6B3juWnzcwW
	 VD4eMmGLRKyNcey6f0u7EMjHmddSiq/e/OK+BorpaUZi+WniZA+GtUtc9Sf0m7AmHwr79
	 Zkr7YhGw49tZ1LyE/qKAj1/JfDbZrRps89DrThVNpGARXihcgX4oan9WODESuco/pWqlf
	 QlEjHGuprxIggv5SRrM+DuL7RLdrYBus8dnl7bOjtlGPaAENteLygwG1+tZVdqn9/yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795737626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbi2jPDujmhRc5z5gppxjoRcMRQjvajoDkRklULDng0=;
	b=s+HS8uHKDNvhoqXIw+NGMxzqa5menocNnsTUjosFsoqWxXdCAZgS7T3BCCntv16M65Wv
	 ldRL9cIRBt089dRsvFW2uxrSFk2qd3FfA/HSpYlbDGLhQFk8Iho9J/J0yliOrIDvdapgc
	 ddgHNJe6++CVxUDF50AfhsPxoTMaB9ThvwUkAUukrQ4LmuIUIok8z2+XB3hgfncAvK14+
	 8bWmJWCzgk4GqfOncZKYXjZQ8htnZvqLwLjwYtpp0Q8DhfeyPhbsOwgNMR/e6XVrVB8nS
	 569L2LS68VBpWD0FGs/pbQ9IUSXbw4S9MMvK7VPwMLiFglgaqZU6iz1V4MYPl36O7Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGCFJtq6;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC5606A31C
	for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 00:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3BC5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGCFJtq6
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso4743877f8f.2
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 16:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795737624; x=1796342424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbi2jPDujmhRc5z5gppxjoRcMRQjvajoDkRklULDng0=;
        b=GGCFJtq6+W6CPFGF/ZSFEz958RH/AeA5EoHxtT4RIDGKhxyLfiIkj8VwSJtyz36D8e
         H948/ejyUIZ5xRunN7CqL8amDGNfMN33ZSPKi0usW1tCJIIHqR8cNSbDGIlQKAkCKYlA
         YFxfe2OY5G4KMUkdWR5A0zKdj58fKdJVy12tXfgSn8I7h+zKQxruG9Cad7YIoB2ktyne
         Yf0ziticDpRYz5mRIQD5stRH+w42GwtpQcjukYUrgqJSPYqN95xiteGAmMjACtO46jJT
         sKDYfAZtGdOamjrtlTiOt7CcXPn4T+uMt7PPIeU3UCEuU7oPXvPXFDeSPoxWaLEUBaMG
         KrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795737624; x=1796342424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbi2jPDujmhRc5z5gppxjoRcMRQjvajoDkRklULDng0=;
        b=xzHPbknsPrGYXVy1SHB8iuzxc4RW8/NG/FfpViOrBDGD2YTqN66Zd2fDp5A/gnKwaq
         2Jvlgp4OfYee4HLl3jJqwTbbtPjNKTekszy/ghXFCP2+k12ET3/sDiVLnBvqa/VwLgjx
         oxC9tDck9Yxaq9KDOG2QTmII2ISmM1rtlWmu12AtWk+vTYlUZTipbJfAZwYhGQ0czkad
         qQ9yrBXeqTMH3ok9zSwvZ9BSmRFDj5bjDEYvBNAmLdnTO+HCo5F4KRVqCsQLKVYWeAd0
         o3zsXGuqh31ifPWVZkLxbGt7/xjmtwMLQAU03JhTV3fWaboQE0uZkS9MTFMurHC436TF
         5lpA==
X-Forwarded-Encrypted: i=1; AL+hErHhLySAyUqDFeelHl/94T1iKnRdNHLn/KY0Sd97/z3u2SVpQ9e92XcCpJn8e+YJ4uZ/2Rv4L+SoWgeJyZfO@vger.kernel.org
X-Gm-Message-State: APuU4Z+QEc/rdOmXGWE3h2gdIbt4c3Sg0kTEw9B/L58bpb2XCgzjiWBf
	kZBYAoV9t5/07khltV3PqXsN+0PMPBb15yfHjNK8VJNwy7CgYfAx58/I
X-Gm-Gg: AZFdTZeKAic/EJJLg6EWjY3fPCnuN/hRU/0hNSqC9ylGNl4AmUF3hC0fBK9OGHxmM0b
	ALDMFVk7dKzSKbvgxz01UjoStXLEDLCndB0KFHXbG80EpPaxjlfs5avL2VjSnX5K7LEPxyg8sgL
	0mRC3ldi0xHxfNPzyzwotcfrt4CRTunOU5Rpv6bDAVHWnLg17pQS8k4UN8Q7cbi17bOlWEFJmm9
	CZy8KKYgsZ8u6N64q3zZzulyp/2/0m2ov33NYU8UFatFcd6Bvlbfo3IMN1IxO8Hfv/t+FBmNuDm
	fiRyolMRygRiacGehISg41bNbNxcIVS4dNBWER04TtlFcburZO//Opwd8cpxE3S1sMdoW8ryUWu
	BDxuMZIVLHurKY8xTyg0hdK9RN8XrkLjw1/D4H/nd98DlJgdTSG4xrtnxP2AcFAn+Q45XXRHWqs
	aXE5ZJzFTczsBa5OkIFtt3A7pRZHzUaDx4k/Q0jrU1I7Jwx/hl1zkU7DyXkOCb1wQCv/8qEfh24
	EOaUiYiDD2VIB1gLcFjHVK6gL9nqgOzEYc56VzWySBnP3bqJP4+iLyiIqNBCkxHAbC5C3zKIZg6
	Y1I1g6B1oJ9bcKvYeLY2xpGS5tawZB9hV1AHsiMRKNXSHLjxzmsqypnpydFPdA11wcO0a/YNjfk
	kYw2qnohxwZ5T0MeHHA==
X-Received: by 2002:a05:6000:4024:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4abb4f59b72mr44345292f8f.29.1795737623844;
        Thu, 26 Nov 2026 16:00:23 -0800 (PST)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm45536616f8f.29.2026.11.26.16.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:00:23 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: samitolvanen@google.com,
	torvalds@linux-foundation.org,
	ljs@kernel.org,
	david.laight.linux@gmail.com,
	sashal@kernel.org,
	lzsx618@gmail.com,
	zuoan.penguin@gmail.com,
	petr.pavlu@suse.com,
	jani.nikula@intel.com,
	xur@google.com,
	sidnayyar@google.com,
	robertusdchris@gmail.com,
	acourbot@nvidia.com,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH 0/5] kconfig: fix slow 'make oldconfig' by reverting host header simplifications
Date: Fri, 27 Nov 2026 00:00:10 +0000
Message-ID: <20261127000015.3662267-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Linus noted when reporting the 'make oldconfig' performance issue [1],
when the kernel's internal hash table implementation was copied over for
Kconfig to use, it also improperly simplified these headers.

By passing '(key) % HASH_SIZE(table)' to hash_head(), this caused a poor
hash table distribution due to using the clear lower bits with power-2
hash table size, leading to a slowdown in Kconfig's expr_lookup() which
makes heavy use of this.

To resolve the performance issue, let's revert the simplifications such
that the signatures of the host functions match the original and takes
the number of bits. Also, replace XOR in Kconfig's expr_lookup() as
suggested by Linus.

Patches 1-3 are pure refactors, restoring code from the original
hash.h and hashtable.h; 4 and 5 resolve the performance issue directly: 

Patch 1/5 reverts the removal of the bit count parameter from hash_32()
and hash_ptr() in scripts/include/hash.h (needed by hashtable.h in 3/5).

Patch 2/5 reverts the removal of the 64-bit path from hash_ptr(), so that
potential future callers can safely pass higher bit counts.

Patch 3/5 restores the original names of DEFINE_HASHTABLE() and
DECLARE_HASHTABLE() from the in-kernel implementation.

Patch 4/5 reverts the removal of the bit count parameter from
DECLARE_HASHTABLE and DEFINE_HASHTABLE in scripts/include/hashtable.h.

Patch 5/5 replaces XOR with addition in expr_lookup().

Link: https://lore.kernel.org/all/CAHk-=wi_GuySe0L-uCAM2+nScCLYGBp5BLi6UUPR1gALmNM_3w@mail.gmail.com/ [1]
---
Julian Braha (5):
  scripts: add bit count parameter back to host hash functions
  scripts: restore full 64-bit support in the host hash functions
  scripts: restore host hash table macro names
  scripts: add bit count parameter back to the host hash table functions
  kconfig: replace XOR with addition for expr_lookup() key generation

 scripts/gendwarfksyms/cache.c         |  4 ++--
 scripts/gendwarfksyms/die.c           |  4 ++--
 scripts/gendwarfksyms/gendwarfksyms.h |  4 ++--
 scripts/gendwarfksyms/kabi.c          |  4 ++--
 scripts/gendwarfksyms/symbols.c       |  6 +++---
 scripts/gendwarfksyms/types.c         |  2 +-
 scripts/genksyms/genksyms.c           |  4 ++--
 scripts/include/hash.h                | 20 ++++++++++++++++----
 scripts/include/hashtable.h           | 24 ++++++++++++++++++------
 scripts/kconfig/expr.c                |  4 ++--
 scripts/kconfig/internal.h            |  8 ++++----
 scripts/kconfig/symbol.c              |  2 +-
 scripts/kconfig/util.c                |  2 +-
 scripts/mod/modpost.c                 |  2 +-
 14 files changed, 57 insertions(+), 33 deletions(-)

-- 
2.56.0

