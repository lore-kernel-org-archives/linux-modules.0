Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECB30507B;
	Fri, 22 Aug 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867325; cv=none; b=agLQP1zR3pXXHp76O2dpCVfmD35XgGEPeyXur8CCOvh3UdFcsFBKArf5l2pjWete8P5XH7XGs2jypfpoL3p5Qb6/SU9AfdgUTdtkbA3Sk4/sLWXpE0RoUp9y1G4oPE/2fGxE8quvbugjMsL1E2el7XpIrUF4pC23J5bNlsmeWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867325; c=relaxed/simple;
	bh=WIZhDf7mzHY4XXBEi7WlI+/ym2i2jl+fPcoagVQ5+8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag4lnwZc74ATv2vkOxgfxPNj1Qt5Co11PV2Zm9y0R6hJ54U3KJnbis6lL45e3XD71lL+CGxXXSg7OrueBXRmd19uPLZLwCYMtQbWbw8B0c9AopIYOC0tGM+7TN6+7MMjn5jdPn9F8+9zVa+yA7xA49+Vpl4ifJztDZfVCqu1Km0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKFBkCgG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKFBkCgG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49c9028f7aso144015a12.1;
        Fri, 22 Aug 2025 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867323; x=1756472123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jM/+V6EEGOLi+0vxxWavU3+I5kcXvL1gGtdXlfilR8=;
        b=DKFBkCgGU7hUn+nCTRmYD0hJEB475D+qTb8ZI+Bt32Ckt+0oF/oadkXvL7jSCSB5OV
         wbF3g9zmppOGvQPzan8fNsqr4wvbaOQ/nVnuFkETvayf+T2K/bOHS6CoMONqTdbD7nR5
         y3Auf6tIKTgvJVFyQXsNsXWL03VUiNsb0qVlWzrFAd9mdzNauU+bNjTUoLuI6QUQBB/5
         bIrJdbunU7hAm8Q+CLTBCkrIL82NnFIBP4+qOnf3pI+WN4WSjgikN6im51vrOAru27k/
         vM2Cu017GIdcPnwmFx1WL4ywbub8uOrSnYNBOug9ZXMeCKAIGwQSioOISSkfZjP7mHoT
         j9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867323; x=1756472123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jM/+V6EEGOLi+0vxxWavU3+I5kcXvL1gGtdXlfilR8=;
        b=hzDWCd7F7vbvslhx9ZdPrmMAUzTls+ZB3Opny/z47+m7QR6ZVSk4ybhPohz7dsDyak
         JBu1NIL0K/I4hgD+sfFfk+/eA9Uq08aCDSMRMXi7ok8LsznCVxXAs8cu3LaR+IPjaDSY
         FHctNQqUTigGmysSC/1hPufWtcWU4N+mBK1YJ9wFBHomlm/6l8A4GUcFEe3FJDLcDUuq
         q/KSdWIPEcthmQRFktJnRcsh1mYP8OAW4uxCARzRTDChmQtwlj4RLXsE/+wRbxA3YNGg
         DM19qconVxrbD88HnXJPfQ2aupKUG1RdALAN9d1K9WEPpEf0tprHjn/wpuV4VZeTxJ6K
         ETyA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ZD3zIsvtN6N8kUHqvP4A05GtoSRdo9EWLYnOAasxgVNaAOwf834upyqtKjqsTwxOaTtPImCt//DkkVdrJw==@vger.kernel.org, AJvYcCU5fiOQrR5cEhuAG8VwBk7nUICr2gymF4JF4RP+Vpt4yCAT7B7e/WWzEu9qWfSEttfzbWhJ0ixYPpnT40E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGyc5zyzXMXdcEHh2UQGQXgTikfiJhj38gWK+Zjnu/OLUiWelL
	vDVdK7mIW1qnM2D1K8d+hOMtFXgYCvHFBV01OGpVLEFjcKwDn0hblbaxOCIlQuVlZKU=
X-Gm-Gg: ASbGncv4EJfjPBlTAMDKW+BTxP9G/3xURdJo1oTitB1DfsYRko9tAqS6ulcDOiK5B5Z
	Dr1c0gbp4+cf7TQj6QP/0yyxDgCGzjyg5XSIRmKEEqqpBoL+5bEOG/LtvlE0+qElgHxla09zEhU
	yI6zHzdDZACPLgxemT39T8qQ7tU4EGvz/NGXxrC9rcLjx4MPw5wGVLww4DJGDA7Mp/9Y/Wic4Uq
	uprrEgLam1YqmSwytlIdvuOcND9eQrwbXXeiqhrq68HTayUUq8uFmLC6LXXaAlgfuI8Avl3OjKH
	rIP1wRuxt2iVlAtng8hye/cHWA51aGhs3iRW4jKq2/ZhG7a7i9YFYnCaMk3U+ZMRI3KyzUhK7Cn
	PjKr4HmG6XjR0yW+Z24XAwlEeh1A999KdFp/MWpD2MMaF7qrjZb1ulfJS3IVzCPKWbjbuv7zLe4
	o=
X-Google-Smtp-Source: AGHT+IHlQUIErPrTceEbt6JJyenkgNicDAmZYVylMv9/fpFkT/9KWm6f/UZqXZoTO+9JRhXq14k5ng==
X-Received: by 2002:a17:903:b45:b0:23f:d47a:c9d3 with SMTP id d9443c01a7336-2462ee38fa2mr38746855ad.15.1755867323340;
        Fri, 22 Aug 2025 05:55:23 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed377843sm83617285ad.57.2025.08.22.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:55:22 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 4/5] module: centralize no-versions force load check
Date: Fri, 22 Aug 2025 20:54:53 +0800
Message-ID: <20250822125454.1287066-5-wangjinchao600@gmail.com>
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

