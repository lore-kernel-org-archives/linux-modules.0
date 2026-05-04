Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3E30E834
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927527; cv=none; b=MGk3Xizs1ReU5OdjdDB95IZxvB6hBXk/YxAIedjeyE7DepJjp2o/X+OZ9fWYP1fxGAwus7eDbqYPN/cozh7ZHjVuu3gXYodq+udSvA/GxRcYCXIc8uyWvgLvUDaLEk1kGDM80DE9mfow8tw/+1x45PcmtfB1kLj724rfUvl8Hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927527; c=relaxed/simple;
	bh=zu8zqDW4h4dx4V+1PKHBcn6qe7oPdJ+ifodfL/4d/lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mk5YuTuvfsK4yVkhZ88rYEUoT4jvUPfU9iX3keL0+04tMcO1HHQ95TrCZu+Wsx7nnamJF+BsNfCpwpE3QHCLDRy+zvK1Eyjf5hJuC2g4vOJoORlP1IGaNhbd1EHD0wbrlHh05Ob8jIViYA1ic/9A8QGNO2Z7onjrBvuGJ5lwphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrYnlN1F; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrYnlN1F"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69498319ee7so2962714eaf.1
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927522; x=1778532322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbxgwKiIfVN6BirlEGV9NUXaN1gnD+W0Y+ioXIR1Pq0=;
        b=hrYnlN1FRwQzm7wYJO5owfJyAAv8R69T58fDmyq7S/6EAlY+qT3rTJOYWIXHKPAlbs
         fQGasE9LS4VZ6VI9Cu7+lSOITcMMrYNZq7SB5EEb80VIVnQlQpbqYM2adOlJfy7tp+jA
         bLzaQ+E5kOffgRcmk2/E871GgxIaFrDht1+lYky/cnLO1xjMout5PfFdvoLpOfjuDcZy
         fntsrZkHKvJRR8ivxLoL0O7BAohSa9+4BIPaGkwpOqYxiTYTihVDxPh/dbybVNSeNPfq
         SfhsvY3oxV45sxBQzFg7rLh7ahn9q0oF4mt2ev9CIg3MiEQ02qgF/VwnR8E4G9dlDHT2
         eIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927522; x=1778532322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KbxgwKiIfVN6BirlEGV9NUXaN1gnD+W0Y+ioXIR1Pq0=;
        b=FeaaBDv9xEiRXUZYxikmTGVfOgIAkUjEVB/7loUM9dm85VjDLWwVi4LbeC+s4F7X7s
         0YoZMHGW48uG4z0Q0MR5eM2VIrhsp2QYUShIKbXFVKK4J6w0W5hHv5D2IWvhGtYCT8bB
         /gvyGa+jjshk+O51OmVVk8ssn7B/Hri0Zs64vemlciAEOXyPhgLj98GSk5GQYv7PTUgw
         98q+ldL+MardEI10EcPN2GUaBhZ8IRQ96FYHJ9WkSxyKfIs8RIcPLvuVxp2bb6mEHHRT
         mhm/A9eD+TrV5UxLAVESyHBafvHCuKAOgT+Be44o13zJp0F+uLekohrLaA4LDemwO6oQ
         z+pw==
X-Forwarded-Encrypted: i=1; AFNElJ+r7ji0z9BTpgXIv8/A5A52Szi/fuyp/ZGBxj8hn8cmWC76/uPtwIKXXS9jpE3X3chF5Wn+9F8C4nOIFQMJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLQglBUL6oFT6pQzz24E9dQnyIViZQp+dQoMmagLih3XZnUee
	dFKirToqmq6Qgwi1PrZwgZKflYZS4i61ecux0jFTy6lZR+ENaNWpKuBh
X-Gm-Gg: AeBDiesr8hZp/rWWXMs1rYUGTmRW3adL4RZPbELWjkWqNJyjuxRyb3u82VUteb+DTu1
	4lTW3HSkLqQ+0NIUcusLJCyG9EPhKBPsvLwY/NfUa1TrP/9TVPwUGQ5PZLE7NrA7D7RD5duhi6x
	w/rID5dIXBmZZlCRpgt2qnng8D6nxGwU+l9ZEQSO1u+E1QZBJlCnB/PJX1++kKz/fKgIxSZCLPW
	jG06dBQT8MJyvRcXGBhTed38AJJWeb/UA/msjWjfsIdvYxHOOjAhWhXFSRF56gW0i57v3lqVnt4
	YOOssWI03kbhBF8FZ84Dp9Zp2G1BQHfTJMlX2hqoFO+d15HmpPZt/Xln8+dv4pVhrfC+Go4dZ5r
	SWAMie/z+rFm422IQUf5VK9JPL5lQpifHjPYqOTiGFENkWNXXs/9LxNxVhT8F7q6ep0pXG8BiH+
	a0ESIkOfWDiKtlwcT30szu0ZOVKTVp1KwPEX7DmPqM0rLHwfyvYCiEQQ598AMZmFH6amVpAgywO
	Q1GeBWuU4o=
X-Received: by 2002:a05:6820:150f:b0:696:177b:42b6 with SMTP id 006d021491bc7-698916338e8mr553402eaf.30.1777927522592;
        Mon, 04 May 2026 13:45:22 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:11 -0600
Subject: [PATCH 05/17] dyndbg: drop NUM_TYPE_ARRAY
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-5-6fdd24040642@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=982;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=zu8zqDW4h4dx4V+1PKHBcn6qe7oPdJ+ifodfL/4d/lM=;
 b=iiHii+Vss9H0pYsNChYziSgSQvbvIe7Sv351rn8+qWxnxEMFtue2rJVzfeP7mPYDadwZihbKg
 ySvhvQyQkqSBHChvslEBvYKxQhqrJr96uidafAT+aQ78xwrNi4SK2iX
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE works here, since array decl is complete.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 441305277914..92627a03b4d1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -132,11 +132,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.54.0

