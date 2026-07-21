Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD943C077
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667443; cv=none; b=PA3st+M9FOhh9PxIlkSsBSZ+HeGRQyufc0qEmcjZ731jeTw2MnP0SKMmxMqy9dM0omBThqYqdKt3eZ2ADJAKM9c43jjh7MxY66pPzli9RvBGT1sYxmK2quRdrQ5Gn+mYswW2tW5IJqd1td677UPecXK1UFsT5rmRQOGz63LYwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667443; c=relaxed/simple;
	bh=R+ywodY9/HEwLU1o/08HL92DtAFTrUi2XM/5yuI7Itk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ow/5Y/Pl/VKJT/bwYaSWdzS/93DOwlPXRE+ioY4yaRG/qrZHyClFr+MqKhud+qCS4I3aI2pdgGNGtd+A39M0iYlbcsBZrkASzxe0EH8I28Ovo7ILZbcjTLrz8NeWExyCfVk39YjSdV7Ph/10wm5hjCCHmGkWDQFbwL+8mJ1NATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQjgGC9G; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQjgGC9G"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so6475386a34.2
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667440; x=1785272240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
        b=EQjgGC9GxQzekN1Zx50JpyYcOmMzib8iIfjnjkZ+LQlu2ybsiLso0sYo9X24CTuqHA
         GQnzZ4LgBkizN1OeNKdKz4jvd+s+v5xhHJDX8xRgMjh9/XPa53fONErpAUla0Fl9bsWM
         3BKX68Uw7bQ9ASixWNv0xFFkxBNnyiFfZIB8ZMJU85M+pwpsXrysFj4WpMjLME85JyCl
         QnGNv8yfYskDsAKeeK4RDHJsmnDjH4hnDJdRqGmAC+qfk+H0ZGcjt28H6RH0ebmJpwFa
         DZBHBUHC1AqvAj1RVEfoqfcvJu0zJiT1zdap0OJ4hFRY2CROYOwjKgXoIlIGZESMhqHv
         Iv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667440; x=1785272240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
        b=J+CAhwSzbcefM/T+vUZJ08qMIIAZM14O/HC3eoJjOLWqRlMVeIGt1O6U6oEQ85jQLZ
         GV/+20WXwUQKq7l/pOqmRF46f2rOctd2A68pTxuDzVtaws+RTP+PwB8T9N3SL4iA7idw
         20fzwqtqPwJa5aUYJQlVd1vF328kNmtVdEKH9KPBZl4vr+QOFucNaHwOFVj1FFe0Eh4j
         P5D4ktUgn7p8Pgx0V2SPMT4c6evvuqIkVHCbhtHPUdl587/zJoAauKPYe17hINBKRmdM
         bufzhb2x+lAcpCL3bsmh8m0dc5qrT0eLPp+G5c4Ri/hYa8d8ft03XKsw2WLX3MwnRWPH
         rssA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7A1/rasl/DawksjpykQFoxiUIL2osqOU0m3uTGGaMerelHzFpOSx+N4gLeGVWb4ZSgnWd6HKAvW9kMtfv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpq/JYNYaYGzC7ovRh4spnMnDIUKzCKhoA8nbJ+PdmrKcoTpQL
	MkQr8MjcxC2N3jSqnoXAWN1g8PTqT1XriecPnvjLnpjOZ9hO5jelsYPx+FqE/w==
X-Gm-Gg: AfdE7cmZgIFotvxvx1qlESN1k8OWynGLyiEcg1/3ARN4G/sUyl0Ag8h/svGpuMjqKIm
	UR9sASBYBYJSFq4WFqkSFw2ZWZ8RiUHAe5K2BJSmasy8YEo6PPthjBeKO0rMSl7EcjVhysdGbKW
	5F56RoWql1afZbZLC8Zxf6/T5jF1TqAEtuyJYPVYx7utb544jkHWRJv8YDhd3qp+/CFgiKZWym5
	cxnPnWM3fgjNfZLEdY6Cl9fXx2HpPRzAYonHQsWwwa7CMyuIjXwrzYA4mvY1NCHYxueVKFHwSEO
	eFhVmrRJDyzEYfWvjBh2jjmItxlwVW1aFidX8RowzK4rGQWX9w08OjbSbi9bb1zN8uD6Q174GuU
	ftCHLhmItq7LjbiazlDtay9rYEFoTrjsxZJQu5vyfi6TE+o29pphNp/eWX0BIdlECvVApquGTLD
	f47ixrJLjpTHOMHx71fT+JjXQMT9gAlfU7mranyaYCNV/JBfM5eQ/mHj4X5Dk461eBCW6CATqdd
	01En8jKOn10WW9yW5ET7cjWpPMSUC8jxdqF
X-Received: by 2002:a05:6830:6d10:b0:7e9:b4cf:d8c5 with SMTP id 46e09a7af769-7eda4d0f61amr9756553a34.25.1784667439823;
        Tue, 21 Jul 2026 13:57:19 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:19 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:56 -0600
Subject: [PATCH v7 07/29] vmlinux.lds.h: drop unused HEADERED_SECTION*
 macros
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-7-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=R+ywodY9/HEwLU1o/08HL92DtAFTrUi2XM/5yuI7Itk=;
 b=vQYJyP8MxuOQv2u1cH/IFNbnG8o09EQeGls4zdY2WK8vQ/fxaMBvko4DFb9hGhCOlr6txKN/0
 PPhajOOjZloBRtZqJwj6BkpY4kujVHKjVnTzPFcaqBAaTzv5VgUKeh1
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
2.55.0

