Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD2181314
	for <linux-modules@vger.kernel.org>; Wed, 10 Apr 2024 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777859; cv=none; b=VCbShdZFe8ppeQoVi2GFR1l8wUPqTLqFpQDIfQ+GaJyoQDF/4DlsRV2TXOFfHI1v0vMXtN0/fM1rplHFfZt/PGQx/dPbOlObWaLWY04//O/GVwKcZLbAju7QIkc13n4On89l6/29GO3iEnmmerD2ralhx8RohYEPQ+p/SqgQcgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777859; c=relaxed/simple;
	bh=xMMO6aZGP77Uw6u5kdTHAsT7oR9jSNRKOlwYEa4tcRc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u0kv3neKAa/uRs57WQ76xhmx3CPsfE+MZdaFTsLiEGOno7cQQz8u+nZ3k1livKXKCWjvI2r41oG5e+pVY0EOH4zPYKuX9GavG4/Kv/RTmdx/5oRZwfPkE7SNgGuUn+0zsICaWs3DimVSgaJzKa9farezUrgoWsKpZyrhR0jsMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GyHMW5Bi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GyHMW5Bi"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso5128729a12.3
        for <linux-modules@vger.kernel.org>; Wed, 10 Apr 2024 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712777857; x=1713382657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qSs1Be4CKwQ+2h3+x6EEWxYTHxK+KNPpEJBGnih4gRI=;
        b=GyHMW5BinR+Ej5hduBzL0IXUeEUPRNp7yos7sRwWLG6ZK5W0ajY9QmfdOuW98NU0lM
         OI49FmYAIUipG1GiWwruz0ZpwJAofyD7LankDh1FWs/G70cWpOiAuAqk4HDNPp/fz6/r
         qbqcQgABl5xZPAlV1ChHCaTOjW5jiBb2ZgN1GOs5kYzEZ/RbzOHR3Z0F84VU9/wmchdV
         UCccwTH7v2gvEPYVrSTESNK81HbbVgvOYD/k69aXYzdXJQg3XFY5Pv1zyNTBU760yqIv
         7VZ83YINc7yPc5Yx39xvkgiQltWPYotjjn9Top2BpxcZw9dysl2aYenPdZPg2qhrTGZN
         iKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712777857; x=1713382657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSs1Be4CKwQ+2h3+x6EEWxYTHxK+KNPpEJBGnih4gRI=;
        b=Gbuhf009bVXKSSckichYs9r7me9bAK79sDSm9RlbVRmO2qxd3PJOKaZvfFkqsnZV6T
         QaoAbPln48dkZwfYh4QCQjSpQyBqgU685lpQucPlZnOtSwPGwnWXHMvWRL10HvqkFKyb
         RU0L/X/0xlLik62wHMvu5oawZgdfABrTPWJM0BOdur3bCpQpFPKfTFxTrJEhL5UJPOAQ
         TXOq2fFy9b6t7St6B5WvAhG3gXwrot2aqQoJp75YtVNmAIw4gdup/HWKq1Vos4HizQ2t
         D7LO5mgw773gTXS0qaQf7+1S9M2n+SKK9dlVUON0zKwPLrUwxSTD5zIh72UUArp+U/zt
         P0yg==
X-Gm-Message-State: AOJu0YyjZlrZiRggCIGSkjgkPBRWMRv0A+6XDRn4/fp3hv09liY4PZsR
	fCfqVn7GnyPK0olGx4fTe94P1ezVX7xA9BudxZ+h9JpxMRgzc1R5THwI33Yu8efY++bapA==
X-Google-Smtp-Source: AGHT+IFT4CiD98c9VgqhVLXEOO44vZm368oiIi09Y7mZNWlFLMmcvrNVGJhZKWERo+1wqRzpn1au1WCO
X-Received: from elsk.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:dbd])
 (user=elsk job=sendgmr) by 2002:a63:df06:0:b0:5dc:8970:45a3 with SMTP id
 u6-20020a63df06000000b005dc897045a3mr15675pgg.0.1712777857235; Wed, 10 Apr
 2024 12:37:37 -0700 (PDT)
Date: Wed, 10 Apr 2024 19:37:34 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410193734.29788-1-elsk@google.com>
Subject: [PATCH] module: allow UNUSED_KSYMS_WHITELIST to be relative against objtree.
From: Yifan Hong <elsk@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"=?UTF-8?q?Matthias=20M=C3=A4nnich?=" <maennich@google.com>, Ulises Mendez Martinez <umendez@google.com>, Yifan Hong <elsk@google.com>
Content-Type: text/plain; charset="UTF-8"

If UNUSED_KSYMS_WHITELIST is a file generated
before Kbuild runs, and the source tree is in
a read-only filesystem, the developer must put
the file somewhere and specify an absolute
path to UNUSED_KSYMS_WHITELIST. This worked,
but if IKCONFIG=y, an absolute path is embedded
into .config and eventually into vmlinux, causing
the build to be less reproducible when building
on a different machine.

This patch makes the handling of
UNUSED_KSYMS_WHITELIST to be similar to
MODULE_SIG_KEY.

First, check if UNUSED_KSYMS_WHITELIST is an
absolute path, just as before this patch. If so,
use the path as is.

If it is a relative path, use wildcard to check
the existence of the file below objtree first.
If it does not exist, fall back to the original
behavior of adding $(srctree)/ before the value.

After this patch, the developer can put the generated
file in objtree, then use a relative path against
objtree in .config, eradicating any absolute paths
that may be evaluated differently on different machines.

Signed-off-by: Yifan Hong <elsk@google.com>
---
 kernel/module/Kconfig    | 2 +-
 scripts/Makefile.modpost | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index f3e0329337f6..cb8377a18927 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -392,7 +392,7 @@ config UNUSED_KSYMS_WHITELIST
 	  exported at all times, even in absence of in-tree users. The value to
 	  set here is the path to a text file containing the list of symbols,
 	  one per line. The path can be absolute, or relative to the kernel
-	  source tree.
+	  source or obj tree.
 
 config MODULES_TREE_LOOKUP
 	def_bool y
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 739402f45509..efdf0cf39cf1 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -94,7 +94,7 @@ targets += .vmlinux.objs
 
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 ksym-wl := $(CONFIG_UNUSED_KSYMS_WHITELIST)
-ksym-wl := $(if $(filter-out /%, $(ksym-wl)),$(srctree)/)$(ksym-wl)
+ksym-wl := $(if $(wildcard $(ksym-wl)),,$(srctree)/)$(ksym-wl)
 modpost-args += -t $(addprefix -u , $(ksym-wl))
 modpost-deps += $(ksym-wl)
 endif
-- 
2.44.0.478.gd926399ef9-goog

