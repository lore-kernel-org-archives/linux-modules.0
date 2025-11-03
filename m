Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21731B81A
	for <linux-modules@vger.kernel.org>; Mon,  3 Nov 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186815; cv=none; b=STRqHwK+9rr0oHoh7N7SvU8JmRYpr7AAjH39nOrGSDHtfI+jTXsjRiQr8j93kZMrQ9oM47j4eN7U47ivCDC3GUdjp84yFkdypBvP5n9xm410SF12yHOWZ49I5nMoZxvhLOliFu2pbkAit5uzkoKH3w3hUErX7G02x9Q2Ac061X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186815; c=relaxed/simple;
	bh=ZfLqA4q+LlT4KDHK6OgFCUnnDeCp0/yqCM3z3y4ZAUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wnk6A4AqwFTseQe0EMhVk/ABeYo/RWq6FMvnUuOzFY5caDhhNjaRvuOaU0o91u2VYiIw4ugB2wtCbwTjeN/CVaKNPNcbWxwxiXXG2jAHZ2vOLE3eP8527fGzFJ66/jbBDT0/s0vi+GAHrYDEIvo2essLVGfyvqMH73yrla9DLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1XsnXQA; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1XsnXQA"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429be5aeea2so1889689f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 03 Nov 2025 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186810; x=1762791610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKMXNiGZfPIVH217MRjliLXTvp1YDgJjekxykL3Rm90=;
        b=n1XsnXQAt2p3nRKaN4HTnKPHWC569qA8uToA2McZM3UKZJU0HLJHpL+s8xp2ORO7CA
         tNfjzzjpxaTzkE50+HaZGP3+3uaMq9zijiAoSatK1Mm9sygV0nPCfq7e3/8M2EKMGB/A
         FaOg1dCWLFxG8+gOu5kWjq0mbTKmPWBp9SKiqMTpAzGy7TKK4adXM2MyeRH5bYo1xynV
         JxxQxMYvQ8n0KcHogckZHciVzIpkyLnj/n+74NuRjuGivON1k1qA2La6kfBPsGXnvAXG
         olqjcjyUSwRJCRswG0Wsbwj9E3lYkCS6bbAhzttyMWQ13INhBTiFPSFfU9GJTlhmZjaE
         RYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186810; x=1762791610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKMXNiGZfPIVH217MRjliLXTvp1YDgJjekxykL3Rm90=;
        b=vyM1QqGLcTNOw/2oaJ0Hc9jR0j9nLR5PAYZNqOTgjNansQ9Ct9TXonwOaXL/4n1aPP
         yPUUOhSRZ6vnFWzUzTrc4uDwxBRcPIX8l/2wT4Sv9e2Tsx1ghauXhpzvIEDUtIY5BXg7
         j/RQb1ZARJl9IwMAjZE68xmovRNPFA7T+kO0WP+1nUl8lRuKp06JZhmEOh2+cLpQqsyF
         fPuTpyswD8ERMR2O8IgfrSBvIKZbhYkNmjGJmxp4zxCv3SRsZ4McY2SdVDgNfYjiclnz
         BZnjwC2XQKaHLO9/wmhtHFXlx3jLlcX+ALb7gngVNGuz7r7a9qurbsjyLOaG2S3F9upN
         Sg9A==
X-Forwarded-Encrypted: i=1; AJvYcCWquDzrnmKsBfiijx72MxaouQnVJs99g1mevgxUvkobAM2NhF172LPcmSc1VTLplM2de2WDID84oajg2qAW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7N9AckAha/i6knXowlkxcKbSFAVOnJGQPIPkJ7MhxWP+oORcu
	BeWWdx/qw2ILwsiEJhU6Se1Ov5K8vZ0IK2DynoEK/VawSpq0g255Q+4cvf3QFEHzHk5004Hi7jl
	FYe5oQOImwKxybl21hQ==
X-Google-Smtp-Source: AGHT+IFC8uEzBjpjBcVhKIzQAVZ9PgWEyRrTcxIH5OA39bpirlxZf+DPWIWJ65wuyC7UfWssuMtt201eUDa8ubY=
X-Received: from wmna17.prod.google.com ([2002:a05:600c:691:b0:477:11b7:17fc])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2888:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-429bd6723c1mr10520562f8f.4.1762186810296;
 Mon, 03 Nov 2025 08:20:10 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:54 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-9-sidnayyar@google.com>
Subject: [PATCH v3 8/8] remove references to *_gpl sections in documentation
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 Documentation/kbuild/modules.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index d0703605bfa4..b3a26a36ee17 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -426,11 +426,12 @@ Symbols From the Kernel (vmlinux + modules)
 Version Information Formats
 ---------------------------
 
-	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
-	sections. Symbol names and namespaces are stored in __ksymtab_strings,
-	using a format similar to the string table used for ELF. If
-	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
-	symbols will be added to the __kcrctab or __kcrctab_gpl.
+	Exported symbols have information stored in the __ksymtab and
+	__kflagstab sections. Symbol names and namespaces are stored in
+	__ksymtab_strings section, using a format similar to the string
+	table used for ELF. If CONFIG_MODVERSIONS is enabled, the CRCs
+	corresponding to exported symbols will be added to the
+	__kcrctab section.
 
 	If CONFIG_BASIC_MODVERSIONS is enabled (default with
 	CONFIG_MODVERSIONS), imported symbols will have their symbol name and
-- 
2.51.1.930.gacf6e81ea2-goog

