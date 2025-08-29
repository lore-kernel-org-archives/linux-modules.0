Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CC2D6626;
	Fri, 29 Aug 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457391; cv=none; b=DglwVnn6+9BDI4LXALaqE4KbOSMlV8duVHwXo2GNJ+drulPQnZlePmF1Lyf4S69ecQjd00jGroOD+bwSYoYe8AN+MINF2kw3eEgRwarlBh9vxaqbltbWE3VyUmGszyZmUYFSqDzSDDsnSpYVx1UbrduH+F5p2ltEAsnE6Ol+q7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457391; c=relaxed/simple;
	bh=CNNW8H+2jwpH7GuBz/IxBha2q6AgpHxi1qIELosPvSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBbkVQ5D1gqfMuto8xMpqaI0y/Tum4HE4t+5sUtl/5cS6Lta75U3FdIDKXJUJKF+qro6b8f4X3h2OKnGoCWPSxNtrakoFbp+2LASkzI3AryXS7H0RICUN8say13Y/t7A4VKl9zqZje+cSi8DT8b6+gFLvJD/S7CqUbjhoqLbrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll5lfdNY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll5lfdNY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-248c676a2eeso12966645ad.2;
        Fri, 29 Aug 2025 01:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457389; x=1757062189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9HlGwGT0pLc+kAXQgdPzsVmtLcDrXDu6GbAvNPTmaE=;
        b=Ll5lfdNYshAIf04296poDM13qZG5bNffLd8rWmdUSG6TOvJwGhaAZfT+1sa2LU8wnj
         KUfu0BKvDvwMiPieSdR5LKMo8kQFhdwzEdfMpQW4CZN0cZWmZcxr3X49cWzsSS/++ndp
         +NFwwYLkHifkVkDjTfLJbiP6vSP/ONJZvVHwUZcAQwtgq0lLGvoNyHcD9cAZBFuRxVGg
         sZBiiAvBITz/QB7thyPTYhpTfBxVx9++rf/raHmaCQyHtpDf2x6tI6nV+mHjWafeNLho
         Gt6c8IImD56rx7kNkD9/ayKQRuOJmDtoU2m1lYzfz8pN021BD+/Bf6Z7jEAcSW4kmviH
         WFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457389; x=1757062189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9HlGwGT0pLc+kAXQgdPzsVmtLcDrXDu6GbAvNPTmaE=;
        b=QQRUMVKpIdrgOvu1gidSrW3bR/isW/BcogYhc2qc6+ID50qdH9yaase04FlC5VuEMw
         37owrBoCH+P/I4FoSACSoGWpN7nXKWw3v/rVi6vVF6gniVGp+noo930HDDKX29Ci7oQI
         rCLTeGDqDsNhETP1VIAFYeS+xywT+ciR5jdl1KWTCiJmRYGV7x+ZjaNWhM/0Gjmp1L0U
         EXmhSJtMtZHEHxL/S/j5Wl9VO7waNoTYodJl+NM16GoGME/FXtDxtEgtzYgy+TACbhXo
         Guvs/itg9vrgWTp5W/5SYmMK1tYwi1ghaRfKCn634e6kARz1fWDV1wyKcTR4K2uzNK0k
         WwTg==
X-Forwarded-Encrypted: i=1; AJvYcCWgKSDce9jAkRj+r0RFe0UCZDZEayKAxUfNo/9X0D1/5RryIURW+Y+4zmomW5KqE9K4M1Nv1D8Ly/yLrBd9Ig==@vger.kernel.org, AJvYcCX5k8Acy7QwsKULfz83kJlQdYZgjbuv2dXKAEJcM/5EzaQY5lFiRZ8hTZhNcUTTkaH0T7PFjITaF+Nm+aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxToUdCRnB0oIRG9xoFoIK04Xy39q+9R5e6M5u4v0XXF6RjzG4O
	yRZ06FsXz5+YzlCnsn+Ixc+yp1qtv9qnfZqWm4pWsZkDuPutKN6XU9kP
X-Gm-Gg: ASbGnctjQKILcVnMVV2xn1DaaqfXDGg+CLpvPDIPqYuKijJndh+0qxENMoJqBoapblv
	AY+xRFqfEgxY4Xqz4P20OoU1HKL3/HDBLSMncl/HZtfKp6KtUokR/yLGO6rrb3zqYFBj/fh9HLL
	p2/+D2fky08lxaBc6QoTD8RoYl77y3xAbHLd1Qv5WDVBngQQIAaDRsLVTS2zf9k3BuZu22//IQk
	94OqRFxd3LQMPz2+vx+nRHY/lgWk9AKvXAotuiTGvImLxdkLnud9vOZSqwlofwfUNdZOsfl/0T2
	DsdaK2HrW02cOyhvFbxD0TEgtvy7kDewpW0fdoWs5XYbVhwtHkI7Oe9ep+dxmnyii1Ao+8EtMxc
	UhwQBUWnUNcVzTIHPjiK5nube0r1BIX2+GwOpFWiLfwLuq2Myzg==
X-Google-Smtp-Source: AGHT+IFgFKZjtkTGAQrCNbDLl/t8Xm+woykXRRL4Y+VDxejV2v0MdiwV7pzV45adAFsKVLM1cU+0aw==
X-Received: by 2002:a17:902:ec82:b0:247:7e9:110d with SMTP id d9443c01a7336-24707e91239mr256840525ad.6.1756457389252;
        Fri, 29 Aug 2025 01:49:49 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702980sm18561865ad.13.2025.08.29.01.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:49:48 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 1/4] module: signing: Use pr_err for signature rejection
Date: Fri, 29 Aug 2025 16:49:10 +0800
Message-ID: <20250829084927.156676-2-wangjinchao600@gmail.com>
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

Make module signature rejection messages more visible by using pr_err
instead of pr_notice.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/signing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..557cb795fa31 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -117,7 +117,7 @@ int module_sig_check(struct load_info *info, int flags)
 	}
 
 	if (is_module_sig_enforced()) {
-		pr_notice("Loading of %s is rejected\n", reason);
+		pr_err("Loading of %s is rejected\n", reason);
 		return -EKEYREJECTED;
 	}
 
-- 
2.43.0

