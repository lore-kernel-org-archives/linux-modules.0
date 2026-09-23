Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5DC584979
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202914; cv=none; b=tweG3pJ/ZQtgvOmfJcGwRAxu6FaTPVwDX+8l2t/e+tNaVRPug0qM7pe9qRPPvsSroAnMiLd9Mspz2lGqAk1Oj1BjtRzSMGbU5N1Pu89Tvn82YWWE9zJrvKO/3FSVKoIzzzhtCZbDzk3aK9QYvpWdYX7CMMZ/f9Co3EQhI1QNcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202914; c=relaxed/simple;
	bh=9lUeEUf43O4OsPSjpghThL5idlm8fYFS7L4pUake46s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBfyVZzXmQvDfhBYS/VnSE5KUrCljxWF3yPcPrse/MIHYjnTcAhMWlHH09G9IWU02O/zCLAS1PPi8q9Mk9jvJsww6XVnwAYIWLUDmpJHqjDXQMiSaR1AIwPKie8Q9t4KN9NN7I5IQVXQV8MKsKDUL0XbVz/biyhx4dJGPeKzqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwFD93dC; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwFD93dC"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae7089c1so675278eaf.2
        for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202906; x=1790807706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1bPsIBSH9RJdyH1mjOKDynlo2sUv0Ir7YundPy4tLUs=;
        b=NwFD93dCK/l8XgLCrbsdE/6t5UbHtzrHNYyhUAXbp6ZauH8SPAGz41AosleGQyGf8R
         8BxaakmShzQhm/nUjMVR6EnveYSDqtc/NopBUnX2diLtj15PFPFQEgnB4sXrIfT6mABg
         OksLVbyk1nRYWPueH68RHNSRyz7VLKXdPah0Qc3YnN7u8xFSJjST2/kW+xzP1InlcWdD
         BFQ3I8/bCzGhkOBgWdvcoSA3jximpMO8Npo1Dk/1YNhxvEFvO9+s1zEz1giicHXhGhsW
         miKSrK0ZNn2dg6xfYa+J66Wf8ok+JLu5uhTuLyoOojZV0F062giJ2H6BC5swbCozqVzi
         niZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202906; x=1790807706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bPsIBSH9RJdyH1mjOKDynlo2sUv0Ir7YundPy4tLUs=;
        b=VvaUsXYhoqxwPD1/etpD2P9+hMxPWm7aci60ZaNHLe4Jg9DoDklMn6WAmKhUryRqoT
         v0dxHFX9pn22yERScyQsLi7JX0jouCE1vSn0ld97WN5Fv0w/Pzog2WEh8LhzD6X9s62r
         rWFIK8LxBfov1h206YakYu6/ziJM3oh11WUuJ9qITqfDfIdfx6m53NjTonjiByEZoQO0
         SVQY5kfh1w0a/yVifW6uH6ilh0K+CByk12IyN6e2xiQdXkKd547Kry+AwhKcBFaTNDnb
         p+w9doXwpGf01eHxkfZuP1tqgbM/xSmGaMNJMtDkaiXFX1mBPl4K+EnL9Dy2dFkjKZnK
         0A+A==
X-Forwarded-Encrypted: i=1; AKwUvBxqvm/VKsmBahblJc3U2EZXwfXMGHumDlPqzvzr2Tvoh3yvn6+iV0ybYlBPOpbU7j7EQ36RHXjaYcH+u0JT@vger.kernel.org
X-Gm-Message-State: AFuF++lnOHSkJDBk3HOXIG/ML4byui1Z3BMp7a4jqQ+SnBBJGI8tHZ4w
	7/Fs3PsKkirEYzGYIw+hbVJm8QY2nNJck5dP7PhV9hg91wiPALs49BNw
X-Gm-Gg: AYBFou10fDiNm+7yb3+PW/KWLmppL2L4tubCYLtraoCz1N7VAmibLu4O2lPzvuTOv5Z
	MDtqctq5yByUBr8Kye2Jo/h5GD8ODoC7cxROpMaw8joUYUPGUfwhqZrZM4oAwFcMCs3iSCwZF69
	dWgnbno17f+5y6MLHoJkMyQ1++vvxHfAZac/lsHZMp0kBgvEa2TGMX9lpKnMrnyx/dX6Z3UVbTl
	PIkQUa7FT0LtStD1e3u6nNNXVBj7hPXaaz5Xd98PhVbapD5Ep6zG/QhV2chdOzjIhYNs4sbRZ6w
	cxOQOwyep+GHMKJX8cV0yfHrERp8RDZQsSpxe9GKK2mCedh/QsGQSYV+YaKEzMWvV6wsdqxPL2W
	XrFn1WDdqVRatJkFJ7QPY/ugVquoi1ngbNl9iMeLO+wrM/xBs6ds09ukO6hqkXDa5x7SoeC3LIi
	FXC4prvlB3EtOsUHwJEk4j4/Bc4SlL36VUqXPTD3f/wFQDr7Y77NISySWiO6i7+87zPY/Ho3a40
	MG8bafKV3JuG932FMsT/+UPo93QMMIDWWThlUOo6NboQxG1RvrLcPwSfizqu24I30vQgMuk5MmC
	R6qON4H+PtH7FbuiTsk=
X-Received: by 2002:a05:6820:178b:b0:6c1:d1af:dd8b with SMTP id 006d021491bc7-6d4412cc69cmr595245eaf.45.1790202905634;
        Wed, 23 Sep 2026 15:35:05 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:36 -0600
Subject: [PATCH v11 12/38] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-12-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=3086;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=9lUeEUf43O4OsPSjpghThL5idlm8fYFS7L4pUake46s=;
 b=sbDzqlFisyDnbimrqXXl+C8tfRzl5ZiAIX3allVEEtSUoE7lRkljJy1fRdL0a1f+4wROKfFmU
 6uazVVCMibgBDQY9764iVLv+SJBugUpQ8TuuSEcFAGbrHlkj0hj9gUZ
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c                                      |  2 +-
 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a39144fd7c8c..a0723343e2a7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -558,7 +558,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 957e633ac555..50916583cb2b 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -319,8 +319,8 @@ function GOLDEN_RECORDS {
 #K= b9a397e807148d13ba07da7db7e69817 FT_grammar_errs.2
 #K= 5abefa504937a329f974504f1896e368 FT_grammar_errs.3
 #K= 1d94d0f239bf40bf51280caeab499de0 FT_grammar_errs.4
-#K= 135035c8a17ae100cc4ec954c4d75b2f FT_grammar_errs.5
-#K= a9cc14244f91a12d3174ad1314144a8e FT_grammar_errs.6
+#K= 9a5e1c1856f1ebbe57a4afdfc4c9703a FT_grammar_errs.5
+#K= b3809a6f9f643f049f1ef30827d4b001 FT_grammar_errs.6
 #K= 5d400aad1a7d71f548b6b81274d00a55 FT_grammar_errs.7
 #K= 61cd359b10f9051862d3745eda07a295 FT_grammar_errs.8
 #K= 567379f4f4d099f00f37d1469d9370bd FT_grammar_errs.9
@@ -339,8 +339,8 @@ function GOLDEN_RECORDS {
 #K= 1f6fedfe222af475211b3bfc6d08bc63 FT_grammar_errs.22
 #K= c67dfeca97697b707acdd70672816dff FT_grammar_errs.23
 #K= 9574dbfdac063409b41a44e6251fbcd9 FT_grammar_errs.24
-#K= 644b81753949ac1285e38ac995eeba46 FT_grammar_errs.25
-#K= 1bf2a93a39961f40e0c2dd4c5e2edc6d FT_grammar_errs.26
+#K= 3c694a0ee2cf3a1d39f2ca8a9f3b9094 FT_grammar_errs.25
+#K= c23be05426c8727be833ff055944aa96 FT_grammar_errs.26
 #K= cdddf4ffd7fde3c12eb0c73770b872bf FT_grammar_errs.27
 #K= cdf7a2e2740ec007efbd29feda478420 FT_grammar_errs.28
 #K= f6650d69963cef433c50e1f2acb899fc FT_grammar_errs.29
@@ -359,8 +359,8 @@ function GOLDEN_RECORDS {
 #K= 1a402ada248d0d50cec13a1af150ea33 FT_grammar_errs.42
 #K= 5b46a8eb0d74009462f74cf7553e3228 FT_grammar_errs.43
 #K= 546e440044828d86135dd63f1eb9ed17 FT_grammar_errs.44
-#K= 644b81753949ac1285e38ac995eeba46 FT_grammar_errs.45
-#K= 1bf2a93a39961f40e0c2dd4c5e2edc6d FT_grammar_errs.46
+#K= 3c694a0ee2cf3a1d39f2ca8a9f3b9094 FT_grammar_errs.45
+#K= 37b7ab754e579683a28ce086c470cdc9 FT_grammar_errs.46
 #K= 3e3acfb800cfb1bcb0cc07f33b75830a FT_grammar_errs.47
 #K= 42dc6cb4fe938bb82b64c82924ef28d8 FT_grammar_errs.48
 #K= cf9320d2188f5b48d508d610d95298b2 FT_grammar_errs.49

-- 
2.55.0

