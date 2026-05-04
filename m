Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B231AF31
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927523; cv=none; b=V6j8VSIMyA9LPeCHAFhg4nGXdb1UXRd3B24MAog2xpgsGvinJ6YtkPINgqv/+qJFUFN9CKg5DfYBweDMyr7NLwkFCPJ10Fd1ras/0rPrtNRGr0+2DceiAaq4j4M+98o0+yyFfZoOtvK21ls9/fWb4BySOFKIAkgkIw3Sy9SipyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927523; c=relaxed/simple;
	bh=4QyJeRXUWgen8GS+6wbvk+BOK50BVAKI45Yo7nMzswY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fqgne9LNx/oScyVEj6M6FDTq9iqayhxlnMB7SOVcmH5nY1cxPedTqLjSCY76hPtkGoW/jMyWYCDtOD1fD2Gs+7Q34w4wjhDgIrCZOFWIlHyl9iXhd2kXFjrAXcRwePLCeBrEWssMzXzdQY+RYgZhs8sr3lhu46uaPdaSE2VTnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jtj0xzc7; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtj0xzc7"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbd801138eso2537490a34.1
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927520; x=1778532320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iz0Lg8jnkq5kxSThshTq+W9uPtGQpz3F9eqSEiSS+4=;
        b=Jtj0xzc7EBfvMqlI4hPQ14miLIpP+WB8Wcg8ILoAi3rB1bYd708mGw/4pw1CuTNVbW
         44O0KzuASqYkNkYadmKiB9DuBf7Vq24mT1mbUNG4++Utxq7K9bdfc+yQSlMimx/xN/ub
         Vnh5INWjRuNBwg36Clzy/iaUU3xlvAIYdX3qFIYl99+WOeNDBt3sZK854dBObIomtcB6
         PCilQG5mSs5yvjzpZ2qv11cSW95RT1TbhcLQlaSX6y2RkkUH6rr0hXSclxjOfFwHtaE9
         /qy+r30hCWXkbNBnLpcCMp/aFpFEZgcfkLaw4HHzpLK1QNrlWObreiY11EdQmph73re1
         jz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927520; x=1778532320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2iz0Lg8jnkq5kxSThshTq+W9uPtGQpz3F9eqSEiSS+4=;
        b=Rb9TW8YAybI/wINPA8jfmmD+MeMMEbzZTgnh0xik7OgXGM249kr7aYF+9y5SleebFz
         TJ1w1ovwduitRZVoXL/XPfl2OapQxmCiU0wYuHcewn1p2ixf3rQmsHa/cCJAp26kE030
         xF5RMfouYyHDN9rOXHGojtJtFTgabBK9V3otfMdUea8BwhpU30WEp+O0wFRruC7lvFy3
         vr94WkqFe6ZzwQBm0ChUFlGA/1DPGdErMNeGZ1NKpIhcBFzuGwNX4BYuq9I4GTd9jCgz
         4xvM6O7FwqVFsCml16Ze9EDZfQR+XxCxZtfSnWQCJDKrRabsHukkgpXro7MSYVEV9AJ5
         GztQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ViUVPqZ9A1rp7pbEnNco11McLyZvjR6k5ncL5gdN135pISW/IUfUcFBp77b7qZ3To5e7zBwjNhe7puizk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3X1uGRDzhJANppkwVs7gGp6oanro8Vamh3eGWx/KLxZ9qeil
	zFMnZ8PHHjUY2dvus7ECCEKEXkLaZrpeW6yoL7JZovawD7VraNLNqD1cxzOqfoxF
X-Gm-Gg: AeBDiev+wmlFzlChYV4qs8mhFTj7FwqQQwcNzetnXkNSnOxizninGckCqEtqv5inkJo
	NkKFcFc5aMXi+PNvYd4blGqrSguI3V699hfen7eYYJQN0uyeWddKxIw6Q+pm4/pfhzk72ZwUF7o
	nC9Rp3RwICdfrJOH7AGD6fc3Ve9v/Zl82Xm9yXuJ/LnXWDH2khTX67bwkcxD1ghwO1ORVjKGfyx
	XYQpmMbStejhyO2UUQ9rDx1I+sPGpSeDKNHiavEmP1QQmXi2QkafV7tntEXBRF/+VxdnMbjxhqW
	X3EUd4e0rPMbKBfk2yfkjWaudyIZ8sowPK1h/LpjXW0daSHPYGEW0dDsymB3PnDlA4NQtnzH9SX
	uAIrQLeKJswZxaSqyiod/7x8bpr6pkIjX+YvN3+A4fLRoNtUh5z6uCDQpvJyKtVa8s3KtdP7jCS
	pmaebdTZ0v1moiy7Mje8rMsX2rk7P23/Qq2Rqd4qgXiMA/kWU2WTsNbtl3A+M0hdpwyrk5lWm4
X-Received: by 2002:a05:6820:4b8d:b0:696:17a6:c06b with SMTP id 006d021491bc7-69887863d2bmr545889eaf.17.1777927520168;
        Mon, 04 May 2026 13:45:20 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:19 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:09 -0600
Subject: [PATCH 03/17] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-3-6fdd24040642@gmail.com>
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
In-Reply-To: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=1024;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=4QyJeRXUWgen8GS+6wbvk+BOK50BVAKI45Yo7nMzswY=;
 b=inxfNkY6lsE+ppdhOmd9kLiU7+Iw4d1ZfSmOMXaWkJO35noemsBnN0vPy71ns7A9f9WWhfDzN
 0rp1fbaQyM9Aam6RkHf6Xtw1qf3p7JJTADX8kK+Q/R9OYDumtagjIoA
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b1e983cfedc..a9caf84ddb22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1166,7 +1166,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.54.0

