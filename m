Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9842FFDC0;
	Fri, 22 Aug 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867315; cv=none; b=LwBhJ79KsfAU44No6SovjMEA8WplFNHoC9F3Ot1b4k9zsb12cqSM7gEB2qvzgkndwXjFs6DI3ESdcIcFqOsaTdSST+FHOhIDcLIE4dIdbghljxTCVKRRIz8kv7+L8XKBtCYADI9iyQiQGLExQsHUgT7SPPAn3fr3DqH6vr5h2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867315; c=relaxed/simple;
	bh=cc1YcKNcOVER/BJnebgIiOmQeCW29Uu9swkM5huo7Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt5sB7Nn+zbl0wwOe5gHeR/qEkSCBF+Zt3SFreDkiL+mcSqh5R91ihYeIc3i8ObHU5z2s+bjWxQfpLpDPRIaJPS6NTvodKCpy+XmnfWVJFCpSRuCNz/y6w7P8YKwHvVwSmE+tYEzs7Ya39CE3HhiCsYR5k8SLePEQMRg0DAe7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ8Favpd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ8Favpd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445806d44fso16998575ad.1;
        Fri, 22 Aug 2025 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867313; x=1756472113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Auao9O9XW0mCi9qR7BGk43RqbCNdwrXU+TczfeHm0X8=;
        b=WQ8FavpdjF04/k8/xDYOhqvF5PRUCIpf2x5q/lhNC93fNvzJGyREVSxV1F177ObRkS
         +5+oCeG10pN1+X6cvGzscJ08Qm93eMGReOveRQdMt1xVVCp+AJ6kU2cp4La5nLFKJCqn
         WhDZpNyUNHI7aphB487f044PEvm6r49Qq131QgYBW8Em2D2OeXzRPCdbFm9dxeKEGFPL
         OdBbsZlbGKwYLhQ9fe1mEzTPK+KHGN0n03mX9wa7Um+WQ0NWy0cbMgP/fIGo2Jg0K2GP
         sJGIOstJ6XOxpwpaQi2On61UWcISqdPtP6F1A5JES2fpH+l78E337GFXuOt3Vi3F9Pjy
         8URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867313; x=1756472113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Auao9O9XW0mCi9qR7BGk43RqbCNdwrXU+TczfeHm0X8=;
        b=C1zDChoe1vsFPUha8wUU2i4YpCEWUwkjE8vZ8bMuyMhhQk7YCzzdyMYjskXQ9U772n
         8HRjue0VXmB00dHb+sy3g0bSaqA3iuSuIBc2+DDrbPVtadkNNwUJ9ANSyogUccsTzD4I
         1GrJRm85SGA7v9k2+w2ED6M8VyW6KOhkpddaGxQfhE6SqcB6FXEM7n0HGrdWtSt+Kpcb
         CIOQbZLeFoz5y+Ekkwzjuv1JY/niVlwf4CMfrT6T5YYapEA0P6e62jyn22M82YCt6yyv
         NHPa/liBdR63aBCrO3mMAXpInG/BRnO7zT2jbZhUCZVNOdGgebtcmsNgqLeiBhiNMprD
         3kBA==
X-Forwarded-Encrypted: i=1; AJvYcCUAs4Cl6tIAiPMqrZKood5nCaWcjJEUCMU5nBiDnA+BHNQ9t4OrPUMFyWcBza1QtOvS5dUWNkzGAjvTwc0=@vger.kernel.org, AJvYcCUTyzx8GILdTXt1ivlQaczcL2vcBJ/zmQzenG07p/Eapj7sZyHZO1dhriZKVR4gqh5X3xNVX2w+N15jljBY6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfl3BM9txZMz4BMQZaSClPzKpXgPUAwvoxM2aLaQhExl8hpT4W
	P1rHtN3jhOmW4z+a2E1wmgB5dBjgBjkViEpN5LQSPp/QS5ZFSU16y9vUR/cQuEeN6ic=
X-Gm-Gg: ASbGncuuPH2rnsOtQ5CiQkpMpiYQWFwewBuhSrxKZmmKlPuksxXq4VDkJNHFHNJc1U5
	U1CGoevC3y848u536a4nZBh6/JRKF0m0aw5eARlym6RcEm+vBzLlLagGlBlGWRxXJa8/egofpci
	8DpFAc0l5AYxWcdQTfMkOJQMADqNulSm7QTCqet6pkIsP8NDyeKEqnCfeZcn83ZAaPQxYX5j2El
	voU0t/f6E7vCWcejXdHwI8BwtHgbEBUuu7LtTq6qkbI5OBMDmZPFz/46pYFtRilL10Rtgd1U914
	cp0naJ8FrpkzVVZ98p+aOoC5fZp2pJby5DXVnUVTJ0U9MX4piIcIVSG8uOoh2PQBX5/MBHwoRL+
	VbUpc+qU7K7MdO2k9tlxARcBvFbLpiqcCK+H7aryaP2KxW97iPi//ULtGCXi07oF1Jpc7Mqmk+9
	I=
X-Google-Smtp-Source: AGHT+IGHI61zvE7JJ234p6bRyxrJOBmVEDE9oigLD8aVog4RR7unS3GkhGneqzRYfXXj/vITAuJ9vQ==
X-Received: by 2002:a17:902:ecc6:b0:243:485:26a5 with SMTP id d9443c01a7336-2462eeb70abmr40895455ad.34.1755867313236;
        Fri, 22 Aug 2025 05:55:13 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed377843sm83617285ad.57.2025.08.22.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:55:12 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 1/5] module: Fix module_sig_check() for modules with ignored modversions/vermagic
Date: Fri, 22 Aug 2025 20:54:50 +0800
Message-ID: <20250822125454.1287066-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822125454.1287066-1-wangjinchao600@gmail.com>
References: <20250822125454.1287066-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current signature check logic incorrectly fails modules that have
valid signatures when the caller specifies MODULE_INIT_IGNORE_MODVERSIONS
or MODULE_INIT_IGNORE_VERMAGIC flags. This happens because the code
treats these flags as indicating a "mangled module" and skips signature
verification entirely.

The key insight is that the intent of the caller (to ignore modversions
or vermagic) should not affect signature verification. A module with
a valid signature should be verified regardless of whether the caller
wants to ignore versioning information.

The signature represents the authenticity and integrity of the module
content, which is independent of version compatibility checks. By
removing the mangled_module check, we allow signature verification to
proceed for modules that have both valid signatures and are being loaded
with version checking disabled.

This fixes cases where modules with correct signatures were being
rejected when loaded with modversions or vermagic ignored, even though
the signature itself was valid and should have been verified.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/signing.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..9e24c79499de 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -73,15 +73,10 @@ int module_sig_check(struct load_info *info, int flags)
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	const char *reason;
 	const void *mod = info->hdr;
-	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
-				       MODULE_INIT_IGNORE_VERMAGIC);
-	/*
-	 * Do not allow mangled modules as a module with version information
-	 * removed is no longer the module that was signed.
-	 */
-	if (!mangled_module &&
-	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
+
+	if (info->len > markerlen &&
+	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) ==
+		    0) {
 		/* We truncate the module to discard the signature */
 		info->len -= markerlen;
 		err = mod_verify_sig(mod, info);
-- 
2.43.0

