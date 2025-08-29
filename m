Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3A2D8396;
	Fri, 29 Aug 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457399; cv=none; b=kR0beKQl4t9CCNlqh7PFadDnJMAP3Mw/Pe66w/myfXREsfQ9aQ3US7pB+K9IoUzl7ZJ8ZYRASLt8IXkc0lS7xa/eWDflNxU10ErwBDqfNnHchx+oiYEv5NflVLEIEmYapHLWKrBaxI+tL7Nfk5cUt4RP+SWqbkKF50UVBkux7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457399; c=relaxed/simple;
	bh=hjGrDsr3uC83afBLDyQ974R48yYRN7PzN3GHmDLxfyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwqaqGtSb2HnGC6nk7I4ws6zQsT79tIp7Ce3FJkSjitmwinpPlCFm79zSvXD5XH5UIEciSivXZoxTdI39fgKuPK1BPJrk8zHZK2c0l16jR5GN6t2giCOcTO3cjh6BLIC7EhcE4fmFvciObyd60WkdMQQzstnXCABrRBCD/TSZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+W4CiPM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+W4CiPM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24646202152so22892315ad.0;
        Fri, 29 Aug 2025 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457397; x=1757062197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxqSnIoWMjfZQAuq/ccEkan01OYjIRKDD3nXH4XpB/g=;
        b=N+W4CiPMmAY7iqjJHle8mzRppeocG9bs+WgYJceC/erA6Pqo6+SEKaS+AbuMHVXzt/
         5Sl9yYCBKA7uHYeUPu0/lEqZ3GT63UGHFf85GgVA7gG8zD9zlwMUVALRJ6uzIPUPIpZE
         aAIysma655Vr6LMzbOZ84mjgbB1gm8mY//xxhaHb4WgoV27CNqaF+zEolOyQLvxbgeTk
         mVK7zG1l1Q+LVNWEIy5/DaZuajiDxdVEaH8w5bdC6oYRYTO5EyGK8xtWLOtHcT3nMSpZ
         GyHLBS0N0mYYiCGOZkhwwDUFTAYVsrfWMhG8zftIlCdNr16rmObF9PjF1reg23mlsfg0
         /HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457397; x=1757062197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxqSnIoWMjfZQAuq/ccEkan01OYjIRKDD3nXH4XpB/g=;
        b=m3dYqk1UfJllytA0XdxJbZyTkFUKHvXxP4lDyjy9sLXBlE/L2G3iBuy10chM4Hl5eO
         zsqKHvl759WDi0UWskej8/SEXelFZ4QY0MUIvA0qtc+pXi7nokZJQUTp/WN7ekXSN0EZ
         3NULu85Te0e6PAdEalbVZld5DnHyf4+XNOjAbA1TOJLIAvx6KNq+MKGmNkz0yGE9x02V
         zZz1T55W9eI0S41sRqwRgOovLBPMLGLhmUJzypyufEqBpD7DkS68FxC/ivMlTXwIxohS
         uubzDj0iiJd0BxU9lwxWPqbHjkN50Q1GKSWeUXvLxHyNuYvud6rkfo4eGo+gggE456KS
         n6CA==
X-Forwarded-Encrypted: i=1; AJvYcCUeKsERBSKkFhokXro+yRoBIuHiSF6iV5aRALHeJLY9XFtY1pJemtEGm6jADbvIykp+gLbIDSHsB4DTbgU=@vger.kernel.org, AJvYcCWjYFcac1byyz4D9L+WvsHZQF6OG4uAL/tfmbPxrjtj2bnJKGpuYx5C4jgJg5xhs/3Occob0acNyrkImB2OFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlEqCf/KTc5edq0vxVlIlcd+WiDRsTvbkG32hAHFrbzdXriOt
	ZqO08+ZWS1UxrE7SmXZ9kmSYIVDjPZHMK2s5I6tFCZSLXyKd5BnT6M94
X-Gm-Gg: ASbGncsykc3ok9ejD1Kk/USZUvzKuU2EsJsnV/d4LV2YqTniF44Od8ingXtX8YVGYwb
	30VyF+ipnjfxAiy+ov/qAVf3j5T/h5S0po6L9AnRzgIcc9ZWDmcE0B9OA6cFSdNWtf2FZeaWFqF
	p7iN5iyMI8pCSRZhw2qeV6Z9rqybwUhLT/Z3mWKS3J0S48P7IIsjPSA4IObVX0BbEhlfqBljpLD
	ZThtHfMJbyYoCjqzJf7MG8v616yAe78XBdYrUbtDKUC1W+3VaVyImoC2cLqD9QmRxjzZKyeAXDI
	Fk9UVdAMJ8PnjpkSCK8Chhsm6SH25VRO55mXG9pdrn/DFmrDgLCwuYzlvSrNV1qQMGcBMLLd/fn
	Fw8IwP5+G5gwyVHbAVral5d+Hlx12z8/s2n1b7Jv5+JdhBJ2iiMseFuyHXP3Pr7EKp/xVH1s=
X-Google-Smtp-Source: AGHT+IEIefFei2RlDSwEzatGN0qI66i5+W36h8pnrkIZNHDFd+IIkhhRd3zlZgt/QZ1suX8vEunFeg==
X-Received: by 2002:a17:903:1a45:b0:246:ddd6:f8b9 with SMTP id d9443c01a7336-246ddd6fd04mr245733245ad.43.1756457397448;
        Fri, 29 Aug 2025 01:49:57 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702980sm18561865ad.13.2025.08.29.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:49:57 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 3/4] module: centralize no-versions force load check
Date: Fri, 29 Aug 2025 16:49:12 +0800
Message-ID: <20250829084927.156676-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829084927.156676-1-wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move try_to_force_load() call from check_version() to
check_modstruct_version() to handle "no versions" case only once before
other version checks.

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/version.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/module/version.c b/kernel/module/version.c
index 2beefeba82d9..7a458c681049 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
 		return 1;
 	}
 
-	/* No versions at all?  modprobe --force does this. */
+	/* No versions? Ok, already tainted in check_modstruct_version(). */
 	if (versindex == 0)
-		return try_to_force_load(mod, symname) == 0;
+		return 1;
 
 	versions = (void *)sechdrs[versindex].sh_addr;
 	num_versions = sechdrs[versindex].sh_size
@@ -80,6 +80,7 @@ int check_modstruct_version(const struct load_info *info,
 		.gplok	= true,
 	};
 	bool have_symbol;
+	char *reason;
 
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
@@ -90,6 +91,11 @@ int check_modstruct_version(const struct load_info *info,
 		have_symbol = find_symbol(&fsa);
 	BUG_ON(!have_symbol);
 
+	/* No versions at all?  modprobe --force does this. */
+	if (!info->index.vers && !info->index.vers_ext_crc) {
+		reason = "no versions for imported symbols";
+		return try_to_force_load(mod, reason) == 0;
+	}
 	return check_version(info, "module_layout", mod, fsa.crc);
 }
 
-- 
2.43.0

