Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776D190071;
	Fri, 14 Jun 2024 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357139; cv=none; b=LEC9qKnEFj9gmUc6WA2A4sdrWblUrMnSi59AlO8KeekBYsX4toYzHUo7ZUWgE/rAISD/Ck+aTYFtI41bFu5apXNlGu4MBzpA90vgK9vaeQDxwk4zUsqY88hTj5MTpMT0ggDiIBaxGVujj8sf3oOGFrFQ3wm5g8JAh0pJdYa5zQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357139; c=relaxed/simple;
	bh=UWWGN8rwUhoUf3ASge4Yp7b3xfivuopyY+SUJKZCE1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qb/aqr59DYVY7axhjF6T0eaZOlz8JMtpAOAIvcHJCeA/WdrW3Qu56IH0mvHMkVijQkAEP4BdHb5nzfk54oEdIL0nolB84K4xTxFeiO9Ad8Ld8nd4H/mRhQaANifkq8vfX+/31E12GJYX0P+5zmOCCG1Q9D3Ye57nDDlTwXtoF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Myv6I2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Myv6I2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f6a837e9a3so13420905ad.1;
        Fri, 14 Jun 2024 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718357137; x=1718961937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14sEE7yn1U0eUXYZByRzOLPuXHbmQOHSDN3TIPlXPVQ=;
        b=T0Myv6I2BnJVbzZXvWXYaHWfl25aWDGkBD5i+En8peaOCvxc63R5/R1s/26WhF+ZKu
         LaUaB10jGCWSG3gO/o9AMAf0VEFW72gafj+JfH9ToxSzyZRJsPJsEwO2SGTNUOJtkAcG
         xU0/h7epuUBDUXsLur/R/py8wZhGNKuI/XPtgDnTLUg6lwZ2u4CklMwfIMzbyZGB5u04
         lT+IIMl+3n5+xkXHYPKAEXcmBfZOiouLApN7gnhSlRvV4rJ53CtfYfSfMpftlFq3KP0B
         pSDMUTdtIcwH2P3FM0qa6/jAOIAJh23y8ihbBtgtV5MeRcarAladCWseEJNC3IDp2KIz
         el/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357137; x=1718961937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14sEE7yn1U0eUXYZByRzOLPuXHbmQOHSDN3TIPlXPVQ=;
        b=cCpNW5E+49QqJfNkl6RiDxk0e7tsmVCVODD4nW+VDlWNn1JcUGyPvstqxTVKNis8Qd
         mc05y2cX3HEGPADBovWhXkUb6Pi7g7D+Rt7lxksbGrf0mGSACGi1Ff2ITtjMhvVoUe+u
         fT6Y9lZCJZOY5jyyxDRkAhV+jirY1weo43rV0hRI8U9oCY1p7qMho798CJ8gYiAi+LhA
         4dYqqYVShiEcZNj/e4j8DdkJgLTG64lREubDu2SqAIZxCd3NCPyqDPw122t22s7QAc3c
         2xl6gADp1QmqqRvPZFtI+NQri1Q3MfbJsAe8dS2NIdxNcnDrimjaILPux50FYJtv1Dp+
         IOSg==
X-Forwarded-Encrypted: i=1; AJvYcCV1m3/ICls1w+d8n0oH/WemVA6kkPgRd7gbTgt7aODi079r8HJqXq1WLNtWa2wku+iO9lJHDRmxh53Zq/Refhe7P3WdLo8Lm6GG1pQg
X-Gm-Message-State: AOJu0YyVDFcK6mtDAG+CXjU7f5eBjdfpJtdjYyd+BqyUZitFYGOqP5rO
	e0n6i2cQXhVfz06LalELbuDw5jjn4REt/fgwF5di+O/tA9hssWqs
X-Google-Smtp-Source: AGHT+IGXeLZqqIbJyrkcAeI6rs6MxGVpjuOg2DOfz3FZfPTUzzQbVXdgdEp5ZcrINQBEE8kr/RsKmQ==
X-Received: by 2002:a17:903:1250:b0:1f7:13ac:e80e with SMTP id d9443c01a7336-1f8625c1578mr24880735ad.4.1718357137473;
        Fri, 14 Jun 2024 02:25:37 -0700 (PDT)
Received: from localhost.localdomain ([106.13.248.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eff755sm27800365ad.184.2024.06.14.02.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:25:37 -0700 (PDT)
From: Yusong Gao <a869920004@gmail.com>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	a869920004@gmail.com
Subject: [PATCH] module: Add log information for loading module failures
Date: Fri, 14 Jun 2024 09:25:19 +0000
Message-Id: <20240614092519.1611533-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add log information in kernel-space when loading module failures.
Try to load the unsigned module and the module with bad signature
when set 1 to /sys/module/module/parameters/sig_enforce.

Unsigned module case:
(linux) insmod unsigned.ko
[   18.714661] Loading of unsigned module is rejected
insmod: can't insert 'unsigned.ko': Key was rejected by service
(linux)

Bad signature module case:
(linux) insmod bad_signature.ko
insmod: can't insert 'bad_signature.ko': Key was rejected by service
(linux)

There have different logging behavior the bad signature case only log
in user-space, add log info for fatal errors in module_sig_check().

Signed-off-by: Yusong Gao <a869920004@gmail.com>
---
 kernel/module/signing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..6a6493c8f7e4 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -113,6 +113,7 @@ int module_sig_check(struct load_info *info, int flags)
 		 * unparseable signatures, and signature check failures --
 		 * even if signatures aren't required.
 		 */
+		pr_notice("Loading module failed (errno=%d)\n", -err);
 		return err;
 	}
 
-- 
2.34.1

