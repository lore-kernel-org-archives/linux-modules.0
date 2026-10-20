Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505244;
	b=kNyi9MrENBaUygvhZ9OlvS1aanunBdk+velXUgUQV2KiFKaJNjilnxSEu5sbubM2w4Jw
	 JPtrTbgJtn31Z2VigYlmxUhTdreouzvtiuNVM8+Z9sWwRMMWiYjtUjtsEGEzRRTIteXJS
	 QVJ1Vhy347vrnOEEOJcD7xOF88cfVzotbTClLiCNGKoOQSL5nuzksFqGwsqcYGd14SEhn
	 pxWtOJNsFg2DyXGEy/1lRyWtiCUrWgqE8AafZL0AXHjbgGSMQpANP9e1tnggj37p2Riu/
	 uE5DuY+2sLksppJpxmuO64Lh7lPbwb2zPs9EcSB+SCCWdVLNWceb8nnF5dijctxAwmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yqzr7T74YopIyEsmLhSJLIYifVJNuH0p+OusXcMit/E=;
	b=KCr1UVREE3vsLBgVIJsBKLoyukxuyj8LYoyy9A7HbfofJrNUC8kuC78AWo182gPFFhrj
	 Cjv+I7JG2Eq/HwBcsJG5/i9xTZqCWMPdwOovGIm7I58k6UvGW+jnarVgsKKXzTjAfdNJm
	 4jCGUGpBbNN6z1PKQARGaNDkEQ5wmTJa1wRWIcJyloEn7nSHJ5NzCwUh4JCRjj7ER3OO6
	 +ZKTUKj37hImbYiW+JHBslmiKK5J8DzPOuujJGt10oI2EFJzV82UQeGs2uMy4DzCaC8aG
	 DwDeCIkmJYBPctwVNZHBm/O5xnWOd1/w5Y2vwCSZ1bjPi+LKVHENtlSDS5gyz+87E0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="H/DcupzG";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D1606A325
	for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 14:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113D1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=H/DcupzG
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso22940135e9.3
        for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792505242; x=1793110042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yqzr7T74YopIyEsmLhSJLIYifVJNuH0p+OusXcMit/E=;
        b=H/DcupzGIPy2rKq5ryf1glRSjAMq3FJyCOsCh7jelGCke0rWrLJdyeWq8w+1Czdjgz
         w04NTWX3yamH+rVRLOWQuq7Fqmr2JwBY/PgaEXOteldXrMri1yI2Xpe9meckMNOvho0E
         iU7an/A5HtlfJNwVITksCfhWj61kYX5yRJ8/Z5DC6yEprPSXs8slCjq/UtJOFM4onqNH
         /E1Rv7meEsLn6Zr7iKGAtjWvMaSKRNFAZccAEmGQGbWL4CwxsDQE9Su0gzg0UQ9/Ud06
         or8a9BIWR606p9ee/G6TgQBFCJWARiyLykGHceQJeKn68aT3tNhYD526jkLFR/yAgmyZ
         jhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505242; x=1793110042;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqzr7T74YopIyEsmLhSJLIYifVJNuH0p+OusXcMit/E=;
        b=gtbJEaItaBgONQvjig+8Iuw4ra6yz7cLnxT121VqfvwTPL7qQFEVvZyYaeaghTM0PJ
         KOSebZAqp2+JVHoGcp0gX9o0QLdvC96zhiP1qoRIJNhV/+z5DIVnamVXaFr0Z59IL+re
         34qR2xpZSJgds6RxWdvrutqa3avB5XIYUXtnLxMVWq8MUVg1zqbdwatxmy0XvMdS4G0t
         boKC7wReT0bTN2ybvmC2Qus1cpLELiqBecVGryTzs4kQp+U7gpbP8nRGFJPt2l8ILPuM
         AWutz0IADaZADxrQvnSIGsmoBPfaZc7M9qXuwdymbPJYQiwaZMr7Zd+O/bjuEgECtk87
         8/GA==
X-Forwarded-Encrypted: i=1; AKwUvBwYbsMecJaqeEdk1L82Jlc33xDFTN2BlP23eRblCen3B8Wu6XTBMMCNYzn0RQBuot4/MpHOjblt2xjPaXzw@vger.kernel.org
X-Gm-Message-State: AFq9FYLOJ2MtbzZCXNEH1aDrqmsxuQhn4fXQoUVq0NusbsYIyzRSksnq
	NoscDcqnNFF/vUQtCzTvJsn6s/6Ow7rz+v1jR2TIWxBcQik1QgLPvjLbtcII2SxBvhX6gTr4SRy
	EHCx6N1I=
X-Gm-Gg: AYBFou1NNsiJ9kA+WJz8KAdzVgP7N+rgsfyUuvNhDzubgxP41dH5na3JlkEyK6+FlzP
	lapgO/VtR7l+r1eDLdtS+wFvJL7h5FAGiuu0h9npGI+wzyVajibtoS+qUBkuNhelYI5We1bTFeY
	Xr4htLFdGIPgTJEXkAQSnZyhRFeTwnkPJO828iJevlUlEXptOKtLfLnLlg/HEeO7FpJ491ryog5
	RQ0cLXQKmJybbl4OZF6UQz/SHq+elJC4ABqIG1XaJh471hNCSda5XQ3Kz1x3cCF7Y3kUD32oGH0
	qSlwkpoRzwnnkHxPYtAoQzlRXscWN7+OmrDTZDefaN1AEhmyyAW6QaJA1ury8Mumogmyq77hKWq
	U3VwXF4YItGfi72xoyB/i0yXqV19Mq4SzfERzB1mHZKWnbrYEXR1lsktUO7AF5glFWMFOuoyO3Y
	377nf2Stb5h0trTHscy/wzakcsJh/F2y6dMUmQUo4QDsBsgBCFbhVuwvAombbE98UNdbFlLIF6C
	C4iLOn/PomxqA4A
X-Received: by 2002:a05:600c:3b1e:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4a1d75f9341mr256235205e9.12.1792505242418;
        Tue, 20 Oct 2026 07:07:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce1479sm75602805e9.14.2026.10.20.07.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:07:21 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] module: Fix missing taint flags for unloaded modules
Date: Tue, 20 Oct 2026 16:05:19 +0200
Message-ID: <20261020-taint-unload-v1-1-d1c764889afc@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
References: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When recording taint flags for an unloaded module, try_add_tainted_module()
can fail to record some of the module's flags if a record for a module with
the same name already exists and the two have at least one flag in common.
This happens because the function uses 'mod_taint->taints & mod->taints' to
determine whether to merge the new module with the existing record. As
a result, the final report may not provide accurate information about the
taint flags of unloaded modules.

Fix the duplicate check by using the stricter equality comparison.

Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/tracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 9033ff54c4e2..5bcd1c2701f0 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -27,7 +27,7 @@ int try_add_tainted_module(struct module *mod)
 	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&
-		    mod_taint->taints & mod->taints) {
+		    mod_taint->taints == mod->taints) {
 			mod_taint->count++;
 			goto out;
 		}

-- 
2.55.0
