Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795871701;
	b=wxXQVMq3J1RflCMiyYiQtfXjWwFc1FFeu7ZddnUPjb6YeLU68ioSJBgtexYHSuEQX9HD
	 o4cj5SuxGDwQbYGNtta1lYgrw24Axtuv3fh1pjZtoN1l9WJEcYKjkKuX3jK7qodEsL7vA
	 PcUtDHZSZLBBPaEXOdaevDAq31h85RmY140sqZ9t/Nl755UiPfM7jmrMRYRM2Nlb+7eZq
	 izp/9hc/Om2uwTeghLnMQdpurIMLCYKn87n6IMIOaSzJ9i5t5pOO9eMMogdTtMLXe6eXO
	 l+kZUQiQ5HsXEC+TwDoa7kO/0wUwQL3W8Ko4crnU3ke9JYd61Q1spOC2ZB3UrpYILDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795871701;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Cy/7D1A0Vq3wd5wE5jIiTq8zayfOAlBLfwbp7nPEwTw=;
	b=yNr0Uv5rFBdotiLfesB03KLUevvmYeMEo0431N+VbKYGDoQjjKkHW0x1PbKTENVkT299
	 qQR7qeWRfc2WdK3ls3nYVUorIGERc2+HW8eG1bh089Hyuwv7glZxncqs2tBrjCeUwbBCM
	 UKn4lqNS7JGOGRim15/n7Q0flP5suGKKVWrV0TvoMKA1NSsNnDcFdhVLPDXzxdsRIpmxv
	 KRmPWk1VPQfgf3ybU7r0gXLNegugMN+jwncQlz4nhv8M8+HT8kdbIGgvViJGnzCkHSBEo
	 cqs3/qnaERzBgW1lQ35ZgGRqqZeF+uDc6dx3CiyozNoQgVh6n76VYb86xSuvP+zqgOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xQG1G60E;
	arc=none smtp.remote-ip=95.215.58.110
Received: from mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9A606A321
	for <linux-modules@vger.kernel.org>; Sat, 28 Nov 2026 13:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD9A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xQG1G60E
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o+t7kkoM0xPIxADQG4a8tq41KzztOQGyjcQhuoL7Dwo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795871698; v=1; x=1796476498;
 b=xQG1G60EQQwhG98tmJmkPbR9IBrpvG+ERu5vzuawLEd/aMZll3Ml64cz6+MN+hjJS7/UjlXw
 4G6zXz+2u3DGLp/8dwdZJmdOolEMmSuL9ZDOdtdx8UwxHLx2QxSrEPBoUwywFc2xOXXMl0Bag4i
 JGcjlvSvZcTbBVvu7hqAoZmU=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6661fb44f73b8ac2;
	Sat, 28 Nov 2026 13:14:58 +0000
X-Mizu-Trace-ID: 6661fb44f73b8ac2
X-Migadu-Flow: FLOW_OUT
Date: Sat, 28 Nov 2026 13:14:54 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: 958028483@qq.com
CC: atomlin@atomlin.com, da.gomez@kernel.org, huangchao@kylinos.cn,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Subject: Re: [PATCH] module: report why forced module loading is rejected
In-Reply-To: <tencent_192A8A137B6CC69DDBF028C27205824BAC09@qq.com>
Message-ID: <5F50ADBD-0DC8-4A40-9EA2-DD39FA51F7E8@linux.dev>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 November 2026 03:43:17 GMT, Chao Huang <958028483@qq.com> wrote:
>From: Chao Huang <huangchao@kylinos.cn>
>
>When CONFIG_MODULE_FORCE_LOAD is disabled, try_to_force_load() returns
>-ENOEXEC without logging why the module was rejected. For example, with
>CONFIG_MODVERSIONS enabled, finit_module() with
>MODULE_INIT_IGNORE_MODVERSIONS suppresses the version sections and causes
>the module_layout version check to take this path. Users only see
>"Invalid module format" from insmod, without a diagnostic in the kernel
>log explaining the failure.
>
>Log the module name and the supplied reason, and state that
>CONFIG_MODULE_FORCE_LOAD is not enabled before returning -ENOEXEC. This
>also diagnoses the missing vermagic and exported-symbol version paths
>that use the same helper.
>
>Fixes: 826e4506a0ac ("Make forced module loading optional")

This is correct.

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


>Signed-off-by: Chao Huang <huangchao@kylinos.cn>
>---
>Testing: rebuilt the x86_64 bzImage and modules with CONFIG_MODVERSIONS=y
>and CONFIG_MODULE_FORCE_LOAD disabled, and booted the patched kernel with:
>
>  vng --run out/arch/x86/boot/bzImage --cpus 2 --memory 2G \
>      --disable-microvm --verbose
>
>A matching test module loaded and unloaded successfully without flags.
>finit_module() with MODULE_INIT_IGNORE_MODVERSIONS,
>MODULE_INIT_IGNORE_VERMAGIC, or both flags failed with ENOEXEC and logged
>the corresponding reason and disabled configuration option. 
>
> kernel/module/main.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index 34e0204ea37c..010b5d69e50c 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -1124,6 +1124,8 @@ int try_to_force_load(struct module *mod, const char *reason)
> 	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
> 	return 0;
> #else

Suggestion:


/* CONFIG_MODULE_FORCE_LOAD is not
 * enabled, let's just tell the user
 * that it won't forcefully load
 */

I'm aware that's very long, you can shorten down or decline suggestion.

>+	pr_err("%s: %s: CONFIG_MODULE_FORCE_LOAD is not enabled\n",
>+	       mod->name, reason);
> 	return -ENOEXEC;
> #endif
> }
>
>base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
>

--- Thanks!
