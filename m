Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751005;
	b=38mIOpWi9oqeGFxwL1QjbuzdCUnf+EOx1yQOFX0/KFvFkDk2GfA7FbkZvyYbaEaLKlmr
	 4DBBXdYmvuBm5DUXrtCS4m8Ofd28CI2BXrfRtvl8GCRUKq+SqjWXDLMasybEokZH7FBa0
	 L5mxpBD6m+lI4CC0I3VMcLxynBHmYssIJUi0g5j43z1N3jvYbiSCl89bvEfjfxgkjQznT
	 LUvgIVLG+8CLHXA/1NzLKeO5aSHFiO/dQfV5j89PEGbOaYFy+de2ANyZPf3EgtzUV9b5n
	 w9nIbZlGngh1kANT3/1Ai99T1JG2DAzBCBl9oaOdTgDjy449fXjGAvJf2SZmHT54pyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751005;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=coH+7ORomI9v4Ts77K0F8ibnSj3Sz8DDABinu63Pztg=;
	b=fjOI/wm7arxjBf8ZZNIppsSte62HERj273HSLo7ivGneAHVCRIoQIWfnh1ZVPkyIjjjN
	 0Ht13jlvulk2s/QQFNO5l6Tnfw4Hi6SOFXDhINJ/td5HFn219vL/W+tO6GPGWJ/1rY9PU
	 J0Vo1gHiglQzRXRDSi0wmAcm4vWbmmcBX9QJjB6l9zM3s1ARVo2SF9uIm7MyxGG+xCRs7
	 rBjDJ1D2ovHmJvCgWLzl5Due0WINLnWqsGpLshLg8T0ed1njAKulr8FS0fLMna/Rn+Him
	 D0jPTarwTH+D2Q6foFfjDsZ44QcssxvmEsU/UWHyRV5Nv6zWxVVLbS98T4hucjcGlEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IDc8G+IQ;
	arc=none smtp.remote-ip=203.205.221.233
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0903606A31E;
	Fri, 27 Nov 2026 03:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0903606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IDc8G+IQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795751000; bh=coH+7ORomI9v4Ts77K0F8ibnSj3Sz8DDABinu63Pztg=;
	h=From:To:Cc:Subject:Date;
	b=IDc8G+IQPpwaPzA5S9g3TR5Hok9w7Osg0mehgC6PHjTFIdABIEuudSuTarjThFcKi
	 EBv4sULneJhquKuG0v5KXhBIbCa2/JnM1BXy0VT/3dEsotciJ7pe1SyS1Wv+XxWJb+
	 V0bDaOeEPQ5UmMgwsZbeG99XshZIw0yQBfZ6BAw4=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id AD1824FC; Fri, 27 Nov 2026 11:43:17 +0800
X-QQ-mid: xmsmtpt1795750997t9h93suza
Message-ID: <tencent_192A8A137B6CC69DDBF028C27205824BAC09@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GEN0dC20L4iexcDi6bFmCpPZwsf2I5vwxfOW7EDRw/besPmY8MP
	 KMMaf49GuMA5hq2uytf1phU/77+TxGyRrC6V+RNzxmnQmlGDCtKod2SIzp8EtKgIiHULkzmkrWwV
	 IAG0HWTbxMXrtclIFsJ/s/2MfyoIVymDpuE/0XYC4tXgDDhJas74CLK9gMSkjI9KeqCT83CilmVo
	 ac5T3U7RO1nU0zE4IpQDLNq5/IoUkY+VCQEjciuFDsxTy88Khp4OB8RW+d92RZWGMb0kN3tugVKB
	 uOTjkuUSJEchY/hYaIlRbsSegr8AB98jXFshudYaNs5q/V8g12r4PbDJI77iqpmoxV64ymjJwBsu
	 6ji8OqRiYpgG/rl/UydYC9eg3B8Dz/vDHviO71imNsUK0M7rAN++PjmiHpXk0rNADxCdFz6Ci6oJ
	 QvzQq2bZZCvhYvXLZQaa8GaKLGwbjvEWP5psxhazazv9olt9H61A5IWUINzP69CHWEnS5H5eVTIo
	 UFNKNzqmuYnA4IkmE90HcqXB8eh6WHmQtYGG567VU5z3h4pqEbmqwc3n4YGwAeKq6LE21LL73yyW
	 moyBMzKBT2zXjyrAaXqLqp8kYLWdE+nVgVc/msmZBCuiUGDujZf05Jwjpti2e8Q3M/V5UfrATN5u
	 fOY+Xi6X8AO4nteUGMbYTw2X5wvRJCbbzOA26myF6t9ZWG0sgHwH5f8C+UkW19x2ZITIb7IFeMws
	 8FqkH/zCCPMOKS1x/ouEBdSFvgO8bzVo40rGP1rvdHgWYsCjf1FwYrVhntRgkThuBei76pbFDXbR
	 BotTQQozh4L+RPe6JihrRG03fNfGTAb0EFgQuVkuOJSgMd4fzbSzykCCTDGIP9KYrI1E5DyrxvXY
	 SpAuRLW9FEZR93ONL4wi3Sh0ZiPAvB9RyI1tyK+3avQB1CG68Rpnl4/9/yMECjXLHiSOl5MCBYOx
	 BH1OZIqwMsa+Hp+d9qTl9d1MrrkBEcunBZ+aYyLl7LYcXPi7tkYa43X6nXcxQ+XnlRNE5md4p7E5
	 GHlhOI9g==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Chao Huang <958028483@qq.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org,
	huangchao@kylinos.cn
Subject: [PATCH] module: report why forced module loading is rejected
Date: Fri, 27 Nov 2026 11:43:17 +0800
X-OQ-MSGID: <20261127034317.247672-1-958028483@qq.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Huang <huangchao@kylinos.cn>

When CONFIG_MODULE_FORCE_LOAD is disabled, try_to_force_load() returns
-ENOEXEC without logging why the module was rejected. For example, with
CONFIG_MODVERSIONS enabled, finit_module() with
MODULE_INIT_IGNORE_MODVERSIONS suppresses the version sections and causes
the module_layout version check to take this path. Users only see
"Invalid module format" from insmod, without a diagnostic in the kernel
log explaining the failure.

Log the module name and the supplied reason, and state that
CONFIG_MODULE_FORCE_LOAD is not enabled before returning -ENOEXEC. This
also diagnoses the missing vermagic and exported-symbol version paths
that use the same helper.

Fixes: 826e4506a0ac ("Make forced module loading optional")
Signed-off-by: Chao Huang <huangchao@kylinos.cn>
---
Testing: rebuilt the x86_64 bzImage and modules with CONFIG_MODVERSIONS=y
and CONFIG_MODULE_FORCE_LOAD disabled, and booted the patched kernel with:

  vng --run out/arch/x86/boot/bzImage --cpus 2 --memory 2G \
      --disable-microvm --verbose

A matching test module loaded and unloaded successfully without flags.
finit_module() with MODULE_INIT_IGNORE_MODVERSIONS,
MODULE_INIT_IGNORE_VERMAGIC, or both flags failed with ENOEXEC and logged
the corresponding reason and disabled configuration option. 

 kernel/module/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34e0204ea37c..010b5d69e50c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1124,6 +1124,8 @@ int try_to_force_load(struct module *mod, const char *reason)
 	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
 	return 0;
 #else
+	pr_err("%s: %s: CONFIG_MODULE_FORCE_LOAD is not enabled\n",
+	       mod->name, reason);
 	return -ENOEXEC;
 #endif
 }

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.25.1

