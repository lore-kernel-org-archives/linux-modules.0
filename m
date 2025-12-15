Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0427E06C
	for <linux-modules@vger.kernel.org>; Mon, 15 Dec 2025 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835751; cv=none; b=Z7vOwANF4bxeffK5crr0R2a1DXosM7dC+jk9UZuhTUpJrMxfgk429qzDn84EjXnmQ93oEC23pDHYJ/FWKOXAf7ifBTF6w1+I+1MfNXivLnqXs3Zv26QPKNl+JdQCUL8gPEeX90fonlkSNObv1VaJVOfLrAqI++tVWPkph3u4Bvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835751; c=relaxed/simple;
	bh=8N+nHYF+aBMYcEs7Nz2jBZFqhIQnPZ06Wmc/V41joks=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HanoG/yPUwk1edDxqQD9ZROSfU81EaPOFsSOIqTlbofmMRclxttKtqoPM/0owjOmxKYjfXyqMv1+KPNPSH+MCioDBERPmcczywRJZjO38tJdNkeWnO7QZJeZOkx39TCOKo3FFStn3E5jQYyYesw0ZFdnAyhyri6c2tuJlRUMXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZfTCr9o; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZfTCr9o"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c6e05af3bso3724895a91.3
        for <linux-modules@vger.kernel.org>; Mon, 15 Dec 2025 13:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765835750; x=1766440550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VGr3b9V7AcrxvG6SOGcU5EADtZiLN7jX8MS+RnNSYas=;
        b=xZfTCr9oHPBVQIUHI/QCpZS5IpyOoPwCockfnaMre0XWqKKyIZzGRzy6V6WourknhB
         NT1ysJVscdxFTFB4f82kqkMOTstSMhem1rd3aiLbB3+Kz2CkCohQJisGuvTJSIKTZPoE
         8YXFDsMHd4Oj/tj70vvaw9zgirUin5xS+LWtMsaIvIQVSoIW0HYGhqS7j0eUaMV9KQ+e
         dol9X1891IXDt7l4VAWUkbHxO/YPfbuRXjBgY4UDW5ZQIhIMTj8Lb0Mky50qP+lRSh01
         z4a3LR7LIeJYUIrAmaSAgE9TPzOhH/ipX7JTZ4No4aWNqGZtwXfqle57MmLw76kwPBNN
         t7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765835750; x=1766440550;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGr3b9V7AcrxvG6SOGcU5EADtZiLN7jX8MS+RnNSYas=;
        b=UPvovA1jkgCal8fdU4RuBBTIlt7En8RsGg8wedMPOsGlMHkCwheYqm0tLWKAOMUnLe
         xXYUTej6NLrBfPDvQuNH1OMIMqVbWP3C+h38tFv3xygc9ZCIEbqMVmDYYtTEE6+hTzbG
         /Ulqntg+t5M9YRvea5WXZtp8s288sAioFuMFy/6TJvXFcLJsk0yVUCiTWfnGDqaKEMx0
         uJfM9rZkqSB9+k+uH4441nyfbV+DkG5tspSUcwemHOn1MbbT3yPGKRiktLBOU+FgTued
         cOvq3M7v/3hcLP08TkCXGfxagLD9HddJaqgXyS3pE5RmpiSaHT9U3rfwTZq7Woof8ACH
         lSeg==
X-Forwarded-Encrypted: i=1; AJvYcCXozCz/9CIV61MCPQC23QdW4KbK9cGEOKgl/l3diyDuk1GlbEEFjvsesAa223SNQCmrx1JHwP5hoDm8ib9S@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dDTBOpSMt3qfRtgADI3VHMNOCIfwZ6iv85TObgOny9LC9TKs
	CppA38nuWLr524NPNQA8Sfau3H66+JvTETZZx/ttKa2S4XPA1eGUGw/MZHIeozJLA8ixJkfw8gK
	wMiI+ZU+GOG+qjwcQTj2hrK5BrwiqpA==
X-Google-Smtp-Source: AGHT+IGzR4xD8qYjLTUHVxheoGbCafyia0g28XPdI/owv/C6bNEF3ttqQcJTtLgkZq0VVvvrs4Fh4WeIsybPIrj9ltY=
X-Received: from dlbqq8.prod.google.com ([2002:a05:7022:ed08:b0:11f:3701:ba81])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7e0a:b0:119:fac9:cdb1 with SMTP id a92af1059eb24-11f34ac0a18mr8310156c88.20.1765835749548;
 Mon, 15 Dec 2025 13:55:49 -0800 (PST)
Date: Mon, 15 Dec 2025 21:55:46 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=samitolvanen@google.com;
 h=from:subject; bh=8N+nHYF+aBMYcEs7Nz2jBZFqhIQnPZ06Wmc/V41joks=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJkOzQ8PTby5t/2OgczyOK6ADv379c4SyuErbv14/1Rpc
 er1op8eHaUsDGJcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAiFjyMDHNuf3Z5PVtqhzBj
 14mJFTtSfnXI7beKC/G15nHpezP9iRrDP0Wn+0syKs3cpwib508KMq8K2+5XZjm9YnqK25JyGUs tdgA=
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Message-ID: <20251215215545.1332626-2-samitolvanen@google.com>
Subject: [PATCH] MAINTAINERS: Update module subsystem maintainers and repository
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add myself as a maintainer for module support as I'll be handling pull
requests for the next six months according to the previously announced
rotation [1][2].  Also, update the git repository link to point to the
modules tree, which is already used by linux-next.

Link: https://lore.kernel.org/linux-modules/Z3gDAnPlA3SZEbgl@bombadil.infradead.org [1]
Link: https://lore.kernel.org/linux-modules/20251203234840.3720-1-da.gomez@kernel.org/ [2]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..0c18b87925f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17613,12 +17613,12 @@ MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Petr Pavlu <petr.pavlu@suse.com>
 M:	Daniel Gomez <da.gomez@kernel.org>
-R:	Sami Tolvanen <samitolvanen@google.com>
+M:	Sami Tolvanen <samitolvanen@google.com>
 R:	Aaron Tomlin <atomlin@atomlin.com>
 L:	linux-modules@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git modules-next
 F:	include/linux/kmod.h
 F:	include/linux/module*.h
 F:	kernel/module/

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.52.0.305.g3fc767764a-goog

