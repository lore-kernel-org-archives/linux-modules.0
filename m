Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C62D131D;
	Mon, 25 Aug 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113363; cv=none; b=aYyZ63weycPrWnHsd0TK93KRV3RfMcIfn+ZGNPdqkBALwG8LOBEP+ZpaYtO3Vhb7OaJZHaJAGOvLRVLXvoCTconxAA6XdvbdIvssZ7Iyt3gVAxjnvgVcG9zpgG4JNn+UJrBh+nyGWkcO5tKaw78wS8a8AOJmPXNMo0V9bw3iP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113363; c=relaxed/simple;
	bh=WIZhDf7mzHY4XXBEi7WlI+/ym2i2jl+fPcoagVQ5+8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8fO+xkPGNUDNt9f+UnuGM4mob2ILKIbR9UOXFJDDrbGERa+yeDoHSOshpMraMCbZX+tEWDJIC6RhNoBjEbwpA0RI31n+Bny0sdIPslwDHZ776yHesDl4GFVL/VQUArJyVrwhoTCHdL7gV5HCesGV/EtoM8BU5sRXZbaCU7R0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCx04K3o; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCx04K3o"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3626378b3a.0;
        Mon, 25 Aug 2025 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113361; x=1756718161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jM/+V6EEGOLi+0vxxWavU3+I5kcXvL1gGtdXlfilR8=;
        b=jCx04K3o/FgR67ckFFdLceGWv16tBsGkCuUVRwIWSg1GPPWqzNi/KdI5rdX4pTJX0x
         5TPcmFEgzu+u2DpChDMgX7lPiNkSoVbc/ROW+irZmkqd/v06KOGizzWtbr9EL2d4sdpH
         yzV4P670h20EZmjc5FxHkXRPPWFaJGJXVMIDKVxnMuZ0kz6+aveXLm4g6iL71ScPOF2y
         Dpr9qNvbCb5yJbUWI3nH45LJ+aK8m6eu8t+c3kpTkdtQxYVfOSBNyYD3Rq3wKczRv4Bi
         Kw9A1OyPOgnL6NhO7KTii8Qlc+yQ8J3YzA9l3diQXddPKI3FLVLzexbQw9UTe2LVC0wp
         rygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113361; x=1756718161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jM/+V6EEGOLi+0vxxWavU3+I5kcXvL1gGtdXlfilR8=;
        b=w3sRXPhhte2Yr7rDzlTlOFAMo906pSThhkrGGTSz219L/zhM4DuAKoZpzWykt5Jjrx
         c1UaJGzxY32n9ksZVeRkW1JF9EkEQ7kSqrhJQO9dSZsGO028jTnrVbOXS3QJyJVUv67J
         7AllNl56iYZsF3Dm8Ou6VBhAwoJBEuQFsWpXcUbBZPYXIloFthF6mrUecU26vgh2efU/
         vtz8KIi6b5Zh3HrbBfVt05fYGwCdgex95joKn1vN9wXwPYoiGd7g1hYziKQul4cSuJrD
         ek89Gs750JEgU5ra0h7cHI6ZBaIhcFxX9e2amNHuNb+2jB90z6ot6hha5zEAiV2gL1R5
         XolA==
X-Forwarded-Encrypted: i=1; AJvYcCU5mLFq6KCgXuPzDFhVnq1ySoE0hzLSLFU8i8uUhuFU3XDwuY4k960l6bIBsPo6gTMlK00UnMDf3dHchO7rFA==@vger.kernel.org, AJvYcCXrVqFZ3aVvf0pLHc5r7/vosR1jAaPI92IgSBhvsJbqa63AzMw9G34XXfURTTH5+74Ma0tINo5iLla1L6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjAk4VRx0TDjuYcnl5ND6RRrBzsXeIs8l58fIGfRSoQiuQnH4F
	498wf3ecuuth5jSwKqtx2hlYK2JxcekFbhyh3KyhbNrs1/YZYrcQ7BDb
X-Gm-Gg: ASbGncsw8os8plwmYF65WnezldtSdxi2q1RFyz2fgWdXtyX5vefXDf69DpvxKTz38tZ
	mid0GBex3xgYLjGy5Pmapu9NdgMORpduFeoQNsvT03Bs0Ib/CwC+iWYWi6WEQsqR+rBJSlArD5U
	A/kXL7X4Wfpe+0iwXESs4ilVnLpDxIohizaGGrCKgCAvyZe19DmwLX7sD60m4oJgReUI9/dMgO4
	CcFSJS5oHJIt6QX1Dez9Vf0EEQLgozKp5VLKhsHQqp8PzeGRP6YJAYpIMgAwbI2eDUheWFDUbGR
	o3qHCspRXvi7ND1nZcM3ocFnLoz4Pl2XVu2PYI2j7uC/PlfvFudjgF+4xtRPN9pyLK9CpbnI+6o
	XkSEOL9PV7iU73cHuL58ebuFxGTk+BfE7gIXsaZD2DUi8Xud8HSZo0sI74+1JrMqWm6+z4NmutP
	8=
X-Google-Smtp-Source: AGHT+IG+ZZidOrbvpreUm0ZWlnRxIEvBjsw1po70jKNNk3h0Gi9XZAQca/R+zcj5sbdtPNN0Qucotw==
X-Received: by 2002:a17:902:db0e:b0:246:edc9:3a80 with SMTP id d9443c01a7336-246edc93d95mr15667165ad.5.1756113361540;
        Mon, 25 Aug 2025 02:16:01 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b1525sm62792245ad.54.2025.08.25.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:01 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 3/4] module: centralize no-versions force load check
Date: Mon, 25 Aug 2025 17:15:34 +0800
Message-ID: <20250825091545.18607-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825091545.18607-1-wangjinchao600@gmail.com>
References: <20250825091545.18607-1-wangjinchao600@gmail.com>
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

This prevents duplicate force load attempts and makes the error message
show the proper reason.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/version.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/module/version.c b/kernel/module/version.c
index 2beefeba82d9..3f07fd03cb30 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -41,10 +41,6 @@ int check_version(const struct load_info *info,
 		return 1;
 	}
 
-	/* No versions at all?  modprobe --force does this. */
-	if (versindex == 0)
-		return try_to_force_load(mod, symname) == 0;
-
 	versions = (void *)sechdrs[versindex].sh_addr;
 	num_versions = sechdrs[versindex].sh_size
 		/ sizeof(struct modversion_info);
@@ -81,6 +77,11 @@ int check_modstruct_version(const struct load_info *info,
 	};
 	bool have_symbol;
 
+	/* No versions at all?  modprobe --force does this. */
+	if (info->index.vers == 0 &&
+	    try_to_force_load(mod, "no versions module"))
+		return 1;
+
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
 	 * locking is necessary. Regardless use a RCU read section to keep
-- 
2.43.0

