Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D73C062
	for <linux-modules@vger.kernel.org>; Sat, 10 Aug 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723306162; cv=none; b=N9NaWnmUz+GElw/AozFXfcgcPBJBSntmuNQA2cbmSxsrsgeLrhsQrkqQniXlUMVcsdlf6DNjs8/++E9dH7hkG9zNSas6GS30+ou+0g9qleWU1XhvjKgsPpyS5gx6mWSnCEiaSxoP2k2gXB9aKon0Khq95K83KEqvGsgUoJjYSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723306162; c=relaxed/simple;
	bh=IdBblcKxQ8WCn/r/8biRtxbKpp10TtcWFAcYOG7T4R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBQAnJJXJtj4FUPp4alZeb7Ks8waXS7rXF/6JbyEM6niW5e9V85iqR1j1/w7EthAG0XD0NK/J7hj7iBkyvGjM1ZiUnwKq/LTI0jpB9DOCIz0vAehRf/J3fDXdKYhel6LLRCBmdeSghpAawm1h114VE/iMxd+e2I+Q9K0PBgIzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4tFzAIE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4tFzAIE"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70942ebcc29so1999688a34.0
        for <linux-modules@vger.kernel.org>; Sat, 10 Aug 2024 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723306159; x=1723910959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXN8e1FjsCFHcbXdUxjQyGO8udqjF3y4YfAU0R7bRWY=;
        b=U4tFzAIEEI0aGQg4DwzFnm4uLd14w0+C1FOhrv+e0IVmNO/dlYRKUeptEbYPqJ2Wd1
         n9OxfY0jdiZaLBlUZ+iBsmb79m6IzulQ3swe9EbfSgdHPFdJ979LX6IWK8VFxbWw46QP
         E8/eyP82TjjGqK/pF452JPzT0mCc19+xQtNtaHZnfDovzuquZ4F7Ie8G2LbcW4LzBgdI
         ChQk/tgnOq/kDgn3Xb5kAqibD5GKvTyQjEKY8KaKm7C0/n0M5c4TKgFhtzaG5kghnq1r
         nhTQjIYDESls/nHlR8z9FGr2eyA92pI+MdI86dDQYOfu5MLaS7113760+VKT+JnFm+FC
         Pfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723306159; x=1723910959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXN8e1FjsCFHcbXdUxjQyGO8udqjF3y4YfAU0R7bRWY=;
        b=lhLJ5NUcGQlYqTD5/6mBASzWptClFKeILNPZ7BdgHLnZVSpboeJ57I9Xyrh4rqGbVU
         dUGjcDbJmRrXs5um5LDrufE/R6oLVh3hBmEPUEVAeT1Bbrdrm52uXu/qQVpwdBSqT3VT
         R7qcISw28z39rs86RMHRUdtBN8nP63y5mv0OAX0CVjqOaZKt7wadMYcqIetp+F2OWctD
         4/Vt9WotCvU3ttYNkmWFJHVOH/ofxjymiYbXngbxohnkkQypkfEci+Xxpl48GWoM3utJ
         EKfvki24B7JVdtZY4DJcIpQ8416g8xuXaAEwTghz23utfYzHb9FmMPvtpPalYUqtfyaI
         0+3g==
X-Gm-Message-State: AOJu0Ywt8ZhHKGgKhYlxHIcbjj0zFObXkHREp0UNSdNGd+3IkqxaeFLa
	f/IO3GCHvfg3Q+2EgUWTrV+ODLKaniYvW/a0+vVaWHD/O2fa6q7cgwkvjw==
X-Google-Smtp-Source: AGHT+IE1OVlhWESeMFII0zfbcbqXykfhdzhlrP++zJi0PQgNaHDSh6NKXzQUWiHOBbaKNeD3uSHTeg==
X-Received: by 2002:a05:6358:886:b0:1aa:b9ec:50ca with SMTP id e5c5f4694b2df-1b177198c29mr721506455d.25.1723306159190;
        Sat, 10 Aug 2024 09:09:19 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.137.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e65c15sm8091186d6.130.2024.08.10.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 09:09:18 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH] m4: remove verbose license exception clause
Date: Sat, 10 Aug 2024 11:09:08 -0500
Message-ID: <20240810160917.229824-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <172330613666.229774.5993123078340385331.b4-ty@gmail.com>
References: <20240810-b4-spdx-fixup-v1-0-b9c84d637fb3@gmail.com>
 <172330613666.229774.5993123078340385331.b4-ty@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Velikov <emil.l.velikov@gmail.com>

It is already encoded in the SPDX license identifier.

Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Fixes: b5a2cd0 ("Use SPDX header for license")
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 m4/features.m4 | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/m4/features.m4 b/m4/features.m4
index 87ed2fb..6384a05 100644
--- a/m4/features.m4
+++ b/m4/features.m4
@@ -1,19 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later WITH Autoconf-exception-macro
 #
 #  Copyright (c) 2015 Lucas De Marchi <lucas.de.marchi@gmail.com>
-#
-#  As a special exception, the respective Autoconf Macro's copyright owner
-#  gives unlimited permission to copy, distribute and modify the configure
-#  scripts that are the output of Autoconf when processing the Macro. You
-#  need not follow the terms of the GNU General Public License when using
-#  or distributing such scripts, even though portions of the text of the
-#  Macro appear in them. The GNU General Public License (GPL) does govern
-#  all other use of the material that constitutes the Autoconf Macro.
-#
-#  This special exception to the GPL applies to versions of the Autoconf
-#  Macro released by the Autoconf Archive. When you make and distribute a
-#  modified version of the Autoconf Macro, you may extend this special
-#  exception to the GPL to apply to your modified version as well.
 
 # CC_FEATURE_APPEND([FLAGS], [ENV-TO-CHECK], [FLAG-NAME])
 AC_DEFUN([CC_FEATURE_APPEND], [
-- 
2.46.0

