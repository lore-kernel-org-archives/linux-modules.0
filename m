Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137433F59E
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520501; cv=none; b=XXUA+eMLS94rHTQN4tW4e/ryboUxFQpEy+uEdgDkFu9Pi33xPEPhdUFnz3SfTeA0/h6IaBXAeWnH8gAQyrPjClhETFUQjxndkeUrBGi/4KGMRmFSGWhm93Br974Yz64oC8ECflPqd34Fspna6x0IApJcpgTORqls+vprBtnUzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520501; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIkA1TfE7qOFXtr+PxMv5XURCx5seaGUKNCgnPFxDyJvFp6HLnxjCnAbKXpMfktVO9/fuFkD0goskt66CLaQcesA67dT7OWkV966Reogezflnjr8PO4aHA4Ks9CuPtpre9tggVSk/oJ6ydeRtEDdBTzkmGNub2CvsMX+ctZCt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1n9gbVQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1n9gbVQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4904127c32cso11615125e9.2
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520496; x=1780125296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=H1n9gbVQ+PcR7fWPkOtzIrEwQ1rCF7DjxFYd5P0XECMz2WMW9N4Au5Ov859TzBQlK7
         IpZ/Ove0C++0990zu0S2fTNAZHVx5hTyIijZc17oaRTGseT7DBVerY6D99v4jICXpr6+
         pE5b6YmizttpJmiaua3GJngkEBJFzLIK3rBhnOeYumTUSk/6n5BNSkLlWmavh/i3H2KV
         jljF9YvKVU4QxDGenryZpD/GNzC0es012x3J2+wbjrI+ECAwqMkHlF8iiSDT92ROJeAL
         x4Vx+ANvPj9kxbEvrPg2XELJJc9DbXjxZ6Ij4ChcYAOXkrsqkQL+bDZJ20lUARu/JPE4
         C7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520496; x=1780125296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=p+2vcif9+aas3iKSa2UHWfbhjMRs/1NYyafr9mGA+Qqm7E8MYAzZg4tlYupET5yqyc
         3Tglyn98kNgKpSCwqZQ/uYbY4YEg2WZSv6ywNn3JP9iXAlLpfskq7dj478U6AFMikBI0
         SDztjfMh4GbHZRQrLOBS62FrVM7KiHJI56gpvFUi9HF/rWmd0uBYUOocQxHOiUjHVYQM
         0FjTyXfm5IyGsF2mjNdMfFKnRk13VgDBVtBc06+awX+j5iUzPlOynIOzA58SbGyWj8QT
         FLpdbN2cTy/cgY0R4qPO4YZWQ0j6hkbPFbsVFnk98WOB95vrld8Qv9p7DyJt4QyE8028
         1IVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5L+mqLjPQh697GG1XhzhSk+FKkcasfYKv+TEPFeAwkBrFxd+ThVXOyGqdo3NsmO3+v4+d+XT+l/SaKFC7@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsC/nhP1Y0i9t4oHMSfV+i3gllsg3r5DmdkNroVZ7NDTE6RuJ
	IYfzS8ymj30cZqJWtlXvxethEj/3jfTjc9cFbhOPE3sE/0BnmcQgAuuQWYpH8t2JGGE=
X-Gm-Gg: Acq92OFv8H2NUe2iGYYE+05mmFosfpTPlCnD4001mJInqAOnKaVv9f0RiRghkrk4lpx
	79/E1zyZ/R9/0kdJ8yls9Va4v01lt5T96XWTbOIz6Fzzc540WQEk5DKA2JY87800LiWRlLa2Orr
	+Ppl3G9pwM0vLEd223i22BhcXn7DSjnGcxemb6R/V+SG9vNeFklBHQ+5t27keV+Cvi1VeUvsMOQ
	haOdw3dHUEnttgZ/gMyQHiZBH2gvrl5iHrnprI8FHKo3nY8N2c/7/cFX69hCTuoru51LubuCRbb
	YFbmQ3dG9xUNaxl6EFsHZv8hPxLSzPkR9+GLQ3DhZ65LM+3AEyVb4yDl18n1eKv2sxe7AwF3h4Q
	/BhSaHOGnYQ0POa+2NX6n8KvhPcJYC0jAxW4dSpmZWaXP94Moq69G/ho69Kz+N8DN4qO4DrgVU0
	VAtVP7TRBqHTherAZrWYhpYHy6qbwaqc7Az24O+VM=
X-Received: by 2002:a05:600c:34d5:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-49052c07701mr17075745e9.20.1779520496290;
        Sat, 23 May 2026 00:14:56 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:14:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:37 -0600
Subject: [PATCH v2 04/24] vmlinux.lds.h: drop unused HEADERED_SECTION*
 macros
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-4-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=wXPve83EQqKwVYpNzugGXIZFVwTl7ZjlKozjC+ofq5HGuSZxa2pPjv2RM993nzrcpf2HgOQXe
 tD3CZakg70vDthyomfMbN9iNNuTYkFwz6pne0FZR6D1P0oeAnYeN0pf
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.54.0

