Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E535677B
	for <linux-modules@vger.kernel.org>; Thu,  2 Jul 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010489; cv=none; b=Zs+tlMmiAvkxgv+SNq85lxGKhjzkCwDhlExml4C4XERw4P/6ouEHkI4Ao4No26YLsXjeQihcV/f6qlup6GndCDinEs6CLVeNFGdvs4HzcIsDg3nUpVpMx3Z5xGULqsznaJiIaNIGw8Zyiq6N3TUrA62uifSZoahwCukllkPtQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010489; c=relaxed/simple;
	bh=q0cqBNsjJhq7nt/Fn+0S0PJoYMLQXTHQFLMuKicG1os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fc4dOBeGYNd6yiMahDafv6dBxqNwL3Os0plrSNbWpK8XBXZxxwLb53Rkceq/0r71W2sjYFmZYfAWY85NyOnINIL1D3vjYIkKBKCBGGBSnWw8sA+DYpElfLBhx8VK04NoZyLnjn3U3Nl4BrDgfprJMdQ5S/GtTRMfebkAngpW2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atsL514O; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atsL514O"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso827713eaf.2
        for <linux-modules@vger.kernel.org>; Thu, 02 Jul 2026 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010484; x=1783615284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlBJo/XQdbEERc9HqMtCgmiWWOZLjFLBFuIKGxMZvw8=;
        b=atsL514OJm6iUJrq1eOS1lfbUoJgX5q53eoN8jr1JnyFbm4qWXlmNBq0UwYOcfTUgC
         e3o8mbauKXvjLvu3TQ10qmL5ZcZNuSrqT16LO+eDGGPa6AUyoybAr9IHTa0AaIfbkkHu
         Yok6AMMCX7upzsGTdW0RB9nUQSO7ubdxW+tpjYkw5Bet5H4JhSLZnuhOOfUS4hPhBYrO
         GHfRYSj3tOhHOXNqKXWCeZEW4Nr7BD6KBJaWuaYayQQ9ZNcWyjYZKPDstedpD4XYh7BP
         5lLwGjNnXvsX+KSSViFI/YC4l9zPIzUHBRddmj3nTf1HLs2ch0vs1PXGxol9ppsof6X4
         HHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010484; x=1783615284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MlBJo/XQdbEERc9HqMtCgmiWWOZLjFLBFuIKGxMZvw8=;
        b=LTIXO7zpIJaGGTLjUsUW92WUbV9UwP3LMPQ50YMK9NtCoEnVysKsnVouB1V1VK/ID0
         /NK3frkoiMFP/gSVp3sAJBoX0JhRG0+cMxlamVwz61fObPEmamcmJxEYaqoFkuhawX/9
         cDUez9FhPmqjFFYQdLxrLl5L8VU5smU6T+CV8v5/iV2QgE2Aam3kZa/PTxllQrYsEI7I
         V44XRjYt/rIOk6TDY1dYl4n+eGZ77JU/GcE23x87ynh2RC03EiGsIS1nmUzeAxWBLDwX
         CwWtllvsvA/EA+QLX4bMzBsk7G8LHAv8HhsTxBqVJpw2tsPCZsvjVU77LzAiykV1LH+5
         aBNA==
X-Forwarded-Encrypted: i=1; AFNElJ+paVfrN8cGKh8MVOCCDwgtpZrvAxR1ivPIq8zkFwrOVKz56RrBxOMUqwnZavMb8tUFqe5rQr/nmgENb6aJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUZQVYXXBxGLklhhWr5XC27MNcScnZk4y9ylLi36Lj+8MNZVV
	+8egv3cnHRWiYRIGj8+GwwM/RDo1lzeZUwei4JfORr0C7enhHg6bZCNc
X-Gm-Gg: AfdE7ckfyGl/QCcOVxFdzSh8AV0NIUZI88sXvxKd79gdw2JgDVxDpwPah1X4jFnxtdX
	/kVWgdwwFLcjOIM4cUsR3TjSKcu6YlZosJ4ywoQICzi6c7r7Nsv/tML1qn+MdgNigmmvSzH/fn5
	h59JYPQzrE3Ds9Nl2mHiUrleLFuTRaIQ/9oOdlXgJYeberJ0LUqwD9gA5F0HT2/z9qSFU61chAZ
	luHa9rOZD7sPw3U1Q2HR6mT2jiTPOaPVNzE3IuwVuVyW5f9vElbGrUVY4wfRpmFjTM15KgpRs8F
	Jt37cxYTFJyPyfW8T52dr232/3TNL94PDtOAWyrm293H3WB5tMuOJpYThUPlrIE0/YwferK3v+5
	aTXqIeV263lS56CqED3qR3kzi1imohfNS8Ol/HDbEwx7wQEUEbZr3kMTd9mSrFc5laMb6OmjVno
	lWWM/Y8lX1yolLMLbeMbb4DLLPpG57f0pc0ZKQGKmy9GtEbCHp9w0=
X-Received: by 2002:a05:6820:4d0c:b0:6a1:5b81:6165 with SMTP id 006d021491bc7-6a3099c63e7mr4036506eaf.29.1783010484044;
        Thu, 02 Jul 2026 09:41:24 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:58 -0600
Subject: [PATCH v5 06/18] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-6-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=798;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=q0cqBNsjJhq7nt/Fn+0S0PJoYMLQXTHQFLMuKicG1os=;
 b=VLBnJePQ24weqt6kvLJCsEsOmicQ3g1ZFfiRe6eE05Uhgx78JR5IBr9it+BePeR6QsuthgUuN
 7fOI7CzsJ3ZAfq80rD3F9Ah6iX8SU/RrmxXATowwFmINGCjT92n4xuL
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cd6b6c710ee2..efe12fac6363 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -554,7 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 

-- 
2.54.0

