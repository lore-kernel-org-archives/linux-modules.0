Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21558443AB7
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667452; cv=none; b=XZVOHnjQM9Q+4m3GCgSg7ky5sW3hXEQAf2CnwWCKWilDchtrqroJh+Z7ODfDXjnyOglc2dHa/tKpNrSTBYEfh2WFefbVJhoe6bk7MFW8gYjNjt/Oqp8rgkLPQ0yVsrCD8GoV38JMXDs+aeuthY+BH4cMt3cUVxo7VEd8DtGbRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667452; c=relaxed/simple;
	bh=yfxjNCD2FfV6WQ7UCS9hJEIU3/cj9TtYhccgD7F2GOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hsLboOKYH7pUzixJVF8PyT17Arn+vXP9UrzkpkHkEl52SThpYozZyoJaYOnfgJ4LZAk3P45xqet3/rxnVcr4xZG933/A0zbexdPhwUNQ/fIzXuUoCHIVcYj1jfns8KR5GU/0LaoJU22NuYqO9hN0gvRWfdvtF+29CNfqFuwCEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1i7zzSs; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1i7zzSs"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb4d532e65so4555439a34.0
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667447; x=1785272247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
        b=f1i7zzSs4MTch98HP2skO47zoVs0bqER2ez+3htfcbfXAsm0gGHd5pq/lXgpfbKpjz
         nL0g8N4UNVCvt5/G9AP1ZmAzvo2OuEBuQ1h9/ZzHJ5bZF3WiJXtmpUWzf4lU0vQl16nr
         lk0eRNeu2EXDBRsGdQt6NwTPtWZH0Eouokc5gyC5o1NHXCp7ppwiOBf2Er6kscyKxNrG
         hlvrAD6RIMBrWh4VV80JUbtvpl4gUxvZINIl1fvBTRVG8isomQe7OIAX2XS0NDYURW7x
         b9RFgj9lQWzmajle98vqfdB3s9FwXMUUNuKGpRRsFpsuRE8IwEGHG2roA0nMORiZiC6t
         G4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667447; x=1785272247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
        b=ipk1sugppJGCivsH7auO788iiXMTdYfG4GBg+52RP4yu5+hWyJ3VlzVLVUYCc/GMjI
         5BJCr9hlJCMu+PmHcVAYbTrWHKJw+gjvwhLGnMwqYJ/oy7nAcJzcYNw8oK6SFsLAGNWu
         HCXxZGVzlwcBrEt0+g8xG2yppXvggeUzgIlbOTBqeLHayxhPgBh10zhDbjEQbfNo4Hmx
         cDlO5eK6stYGIsg7vz6l19BheZ2KBl0YQ+Duj0qFTo/Xse43hWxeZvzfnmU5/6XTeXvg
         S8LRTeP/zlMXvK9I9fPjdi4VAGZUWMr+1qQt7gpExLlH6jSvBq+IPWxF7Qwm07HGhtg2
         yrSg==
X-Forwarded-Encrypted: i=1; AHgh+Rpdb7yy3RZDwO0icFzmneQwOsTh3uV5iRVbp1E/svKTJx/V0R48HmO0WeK+HdbninesgPIzVNobD1dEilF4@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsgmVvg4Clk0JkLWjYa4n3EXq6eTIaUrV4i8b+2cjUjs3Ooaa
	GGNpoLSBuLBXyHNI0phuGnAkSeXJhJCZUirogPGOJ14lr3I5QayGSH5JO3eAyA==
X-Gm-Gg: AfdE7cmJ609kgpA3iCqg2WU4rLaVI5hC4pUxkVOB6vIm/4abRyPJZu6ENk3iyqtQft/
	r0YZBCFyq04tSRY9N1Xab/7nZ0LsxU4u7osJTLvl/l95Zjy1gddv4wI/S5RsYvardJ4E2P4s7cL
	cDsf2YoZ9OTDmQoIM/E0mzz3ODVZFdhx7kNaXHd9/zMeNY8lkvqEbQY+8wRLmSwDajOyJbh78h9
	h0BZIRPyosLRMzwfiTIGuOTwdk9g6cU10kDy41IMtgnND2XgilXflkb1saivHbzbN/vLgXBn+ok
	FHkbSXlE6LKSeEhzGrYbETiXGm2SR1pz+IPm8vdoOV6vx941rLeLlZu0whOomSuSBBd0tost9oC
	fVIYAOvvkmo1QVuMH5MU9bEXaQQ+4duvQHexRCLb2jKa+XyZQtJLEJMXeyYwTobQMFunxzOnrL3
	l1QK11MNZFfB0KtT01B7sdTokgdHtvAZtPOKEuS86AO5DSGuwWZv6ZRSXGEioX8mRC1BAbMcfg+
	si7DtfsafY3fAL23N1sqNMUZA==
X-Received: by 2002:a05:6830:909:b0:7e9:dbbe:5af9 with SMTP id 46e09a7af769-7eda4d70994mr10261926a34.31.1784667447247;
        Tue, 21 Jul 2026 13:57:27 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:02 -0600
Subject: [PATCH v7 13/29] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-13-010fbe73b311@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1375;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yfxjNCD2FfV6WQ7UCS9hJEIU3/cj9TtYhccgD7F2GOk=;
 b=QF5cQMK6T8UD1YJz5nk2AJgW01BgHiDFKzY+xuJZdV3zwDHcNIHgMuD2tCQNxi+sv49R3fsxO
 T3mOec9MvhtCAxvyJpnSu43qxs3y9ZYtOKNNAHiEMVbFgE2WhPqbHCp
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown, _id:N"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_ _id:N" to loudly announce the erroneous situation,
and to make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports a classmap coding error condition, which should be
   detected in (or before) review.
b- SHOUTING the error makes it more visible, uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 577a07916072..a86e1d5845e6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1170,7 +1170,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.55.0

