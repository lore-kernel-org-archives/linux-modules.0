Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A542D0616;
	Mon, 25 Aug 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113358; cv=none; b=NK/baH1WK2BeGf+BFdcl0/BFFDh7IAPwFcRr0+6O6eCJkomcxFNMg8L7rcXCAiUmxmmujiFVbk0gwolWL0/9ABnMlhzyCuAYOKZ8AZvOU1uXUeS4wt/52FXGGIoniIkDF6O0eIkZiL+YEyt7Wvf9qZmC72xZQzVdTjDbjKLsXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113358; c=relaxed/simple;
	bh=CNNW8H+2jwpH7GuBz/IxBha2q6AgpHxi1qIELosPvSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKJ4HXmSTyV7jZ4zweCHOcAF1vmmrp5pQxzv+kUbfFLGUIxslRNv1t8ucw9uxNay4dUu5DkgFJ3fvnhSEOuf7NgCAdTMKDZErrn5j2Z7cdimonP07TYMP6SnKk1NZoo7qcqRlJYRP/8dzF3Gz21ypSYFBn1oihpkJMb9O68PwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfM6ij7m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfM6ij7m"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2469e32f7c1so7801495ad.2;
        Mon, 25 Aug 2025 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113356; x=1756718156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9HlGwGT0pLc+kAXQgdPzsVmtLcDrXDu6GbAvNPTmaE=;
        b=FfM6ij7mlWaHTiXhH9ACKwcMCx1Bldzy6n1APkX8NdFOKlsrMUUwPJr1XFFEBWItCa
         gqS3TnD7I+WNWaqQXan7YyqVdb9J8IFozSgRAyaTfQuWSpWGY2IS0Dd7Nlfp15ajwE+i
         II29cXO6L4YqpQIGCzru5/MQ7wRlcxq+jID3MkvFyYdFw1Sd5nmtvR3DAHa/oanideqh
         FTlbBOeaf6CoDtSStVuxdkmzKzDS2Se8m4joR5B2QfosGiz8gRZTqupCU4VCD50mXhlN
         AX2dGcY+ZderPNsLSOWRhjy9SXdnaoqoU4J1OaQ4kGCMSoJ10nSOOLD+wUjuJPb1IyEj
         OAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113356; x=1756718156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9HlGwGT0pLc+kAXQgdPzsVmtLcDrXDu6GbAvNPTmaE=;
        b=Nhb/f3tguVi/76umL52ZE4Nq/uTglbnuoR+mX9rvnrGYz2HTET7py/HZQIEfcl/Phm
         C0k7W8uxAt6zOypLwAVze02H9k5yUmDvalU4pl/pMfH4TAsKz2gzF74WjzOAUjUKuDZ5
         u4hxrF8J0SkG1n7h11KNkEzLC7SmL6VCnPrdPwhk83a37cgWwMpb8EaADyI7nJyui0Cj
         b33kNVhednye3cQ5lfd8yqeEPvHX+STgY7i/mHOYabOsGW/jPQOa3OgihHqMypq11cw9
         qJX2GKDQEfwGTt8LmQhgjQVKdfLypws7GHEifT8Y37Rr/jF7OyuwGFdrLUDG/Ss5H11g
         q9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE7mTr/rYQDYsv3Vsqz7xT5q/aqmpYNF9SwsnR5jvi59BRygiII72ClIaUx7q9cMkqh4u4b+DiK0CD778=@vger.kernel.org, AJvYcCW9230s/eAu+47GI0CDddF/F6BdcEaUfoCDBvPukxOwj6CaBsawBalGj25LTGumBSSqAtKVmcKFNfohonSKvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPR5ZCm3mrEWyMOfna7odii26y291qEnhiwIo9D9i127L3Mh/9
	d+kFUbKlWrk6OBAuKDPkoSGcuxu3hgLEvW6a2Cp8GHEC2hm+H51ZordKBgMP9v7DnKc=
X-Gm-Gg: ASbGncvgKyDRHkyCizwyV1u2Q9B7eXL+svzD7myuZG9OW7OoxeSr5X16HjOoYj165cR
	ojincZWMULyG5X45dBQVkrB4VFDiD1LSKAfJ1NOiBR9lFectmSozIciwoLaD8jkOyrDEp+47uRL
	H/yfuzVN456fL9rCJh0gFDNbJIcHYK3x+kyjzToa5gMStBbxoRpiHoJm0LDq3BTU5AVBVdzmuMU
	ixREk2/TJ2i/33nnqyZb6LhtBRCR6o5D3w6Yojf12d/Xnp2xTcs/m0B2XaurI8SOqKmc2fR9E2h
	0e3YteuI0iDKBbVwAXDUKsu4HP8Fq+12vuZe6gjgeMaZqgKg6vT/H0TC/DIY3Od8vF24GUm/4sb
	/i15wwrNWaiEV8jwDeqOXaucqddrLZmo53YIlo6/0yIZ2a0YpL3FU+OETuUdEluJ+p59groMbnu
	RBab5Q3NghtA==
X-Google-Smtp-Source: AGHT+IHTkmLu/6zWl/V1gBMnBb8A3FYn+iQoodvtElUwS+H0DmmNzK5GohGgBbsY+0JWSNKI/Rc0yw==
X-Received: by 2002:a17:903:22ce:b0:246:e885:46cf with SMTP id d9443c01a7336-246e8854977mr24568255ad.16.1756113355887;
        Mon, 25 Aug 2025 02:15:55 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b1525sm62792245ad.54.2025.08.25.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:15:55 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 1/4] module: signing: Use pr_err for signature rejection
Date: Mon, 25 Aug 2025 17:15:32 +0800
Message-ID: <20250825091545.18607-2-wangjinchao600@gmail.com>
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

