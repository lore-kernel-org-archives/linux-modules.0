Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC3274B40
	for <linux-modules@vger.kernel.org>; Thu, 25 Dec 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766682579; cv=none; b=dgiFC0R//Mtnimf59q5l/7EG6WzOBDG0mo/oZn73BWqn45epjdos9SidQIZiGudLnUV7cu76Tb2+8HYHh+0ys9HcHf42ZGugMNZsCi8cVuVtvkTfiyUXKW1m3pDWBCJSMn2MWd7Z1IFeqVd70qRtW4tDRJJ+g9QsnaCdLtPi45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766682579; c=relaxed/simple;
	bh=StpIGDCYbsALR3Ba5LOgwHS3EyBzqwjbuM5PV4Ik6eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHro3dhKDSYRLTq/Hh8NlHknui6MxQbtTA7TYWb5wcumVjrU0hIrBEnO8M8Rh1g62i2K5J2IH8Ehz8FjoHrm9kYhxzUiaP4zGOsWOf5CrtxFWT8jfE9grchwb8DBt1BXmIRiJfzx33YQfJY2Wgxi7Up8TTq1VuAjqvTCaiEHxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQJphvVU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQJphvVU"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7881b67da53so54951107b3.1
        for <linux-modules@vger.kernel.org>; Thu, 25 Dec 2025 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766682576; x=1767287376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNd78aAqU5EbrtjfwRe6vlIJ1RKc0HFvUVEnBy0vIWA=;
        b=hQJphvVUfAdwnxTi9K2gpheLbqAND07XlpvGPpLlLUdZrIEmMF2AXsA8gF4+pkqhye
         8oA4dGg9SC0DdMb6no9afhZ30HOFcPcvGQO9b4rQHCjF7EzfemTj3kCPnjK+QHlDXe4T
         UqsHFlp4QyBYN4YXwTIFkkDECwD2wgWk+kVxDb7pcRHibPa52pr9T5A5f1oiHP9JN2mF
         Z1jGmJgvNm8W1kmSlE2gwh1Sqo5UYok03LzVdG/yt7kHzgR5dGBDY3p7QaH7ESWgRI/v
         GxibTQMmj5XD3KKG+/JoxOz7TSLNX860K1UfgSC6RDwCNZdhtzCSezyZa8iZrAd7FHK7
         f1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766682576; x=1767287376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NNd78aAqU5EbrtjfwRe6vlIJ1RKc0HFvUVEnBy0vIWA=;
        b=f8eamufXVpkccyaACw5PN+XME1XizoGdDWKyKyYIF3MHVp99wMx4uhI4BlH/jl3uM+
         gq5wSDvVHX+ztFpkT94pUEkKYCWtmPvEBjDn81CBgLD4yQj7ZjsdoNhj7Itcgc9RYMub
         yJD8FOhP5hzrPzs5Ul10BUsnx24UwUOEtHcAKsFNFjG0XlS2T09wwNU8If4SkYedA+Oc
         U2GeWKVmMGyOC+LDOQIGqrinyylte7nCOppZdyQNL1/knYJNwVnqsVYQ33ZcF5TKBLzV
         GJIto4wkm1mG3hyGGQlNipZpWY2OP/itZZizlYuSwHo4GXpeyvhUxmni9ZSFPr6zoTgh
         Lffw==
X-Forwarded-Encrypted: i=1; AJvYcCX8lq70B/NKSQg2BF2/qfVNHqmewYtRKyWCKjeOb5zrwnFg8RmeZkwRNH3DZ19nzDOIOcrt6lA29DVrSdT9@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+TozB/l4pjsXbWfe5zDh9KKwOwrrbUD6awgizeTR1xfCD/Yt
	+GTpM3a2LvfrKooRhJCTdUP0dBDd0IgXmqnjCItUdpyurCYPPmCO3hEH
X-Gm-Gg: AY/fxX57KM6C2gZzvdxBgmTXaIi9fgJdh80/cHbVl/62DgYwzUZlvbhMHbCrytbC3La
	X4VUW/ATurbgegvFCB2DW2b3bmDvo04Mx/U+RgnETRAA7nzGe6IfpuXcU40y2ttuSSZxn4T0Qgm
	HY9HcNv4INY6YEIMAj67hx7+Yf/KQomTkeK9R7KQEcvl/ogP4ozXGz7kVrJ8TL+mUbZOVPC9KJW
	+0AWzTj5AvKeTuQ28pfbj2xBOlzOa7PBmomjiSWPWGYHCKRyuCfZYBlqhG9InN4XY/nTJS8X8o0
	fPaZ4954xwxckbUwx3wPJqXRLux9/Slrwt03rw0wrmmlcsWEBbtl6NyKaCv428bxuc4xboA3k0k
	0HbXwqsGmT4zXm5e49B5YL4D0cSUix5Adqz4UVpvCdi8QtPy46MtvxMq061JZEkXIgglFLt8pSO
	Jj4nhydQg=
X-Google-Smtp-Source: AGHT+IEiizqa7gXB/ACCt9JE7Q6rU9XXmV2EFcojqYXAdUzX6FLa2edp+vH8KkFhKHQ2zor39oLYCg==
X-Received: by 2002:a05:690c:4989:b0:78c:2c09:4748 with SMTP id 00721157ae682-78fb3f7e542mr153887627b3.30.1766682576087;
        Thu, 25 Dec 2025 09:09:36 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:5a70:118b:3656:4527])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb439b8acsm76287267b3.13.2025.12.25.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:09:35 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v4 3/7] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Date: Thu, 25 Dec 2025 12:09:25 -0500
Message-ID: <20251225170930.1151781-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251225170930.1151781-1-yury.norov@gmail.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro is related to sysfs, but is defined in kernel.h. Move it to
the proper header, and unload the generic kernel.h.

Now that the macro is removed from kernel.h, linux/moduleparam.h is
decoupled, and kernel.h inclusion can be removed.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 Documentation/filesystems/sysfs.rst |  2 +-
 include/linux/kernel.h              | 12 ------------
 include/linux/moduleparam.h         |  2 +-
 include/linux/sysfs.h               | 13 +++++++++++++
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index 2703c04af7d0..ffcef4d6bc8d 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -120,7 +120,7 @@ is equivalent to doing::
 	    .store = store_foo,
     };
 
-Note as stated in include/linux/kernel.h "OTHER_WRITABLE?  Generally
+Note as stated in include/linux/sysfs.h "OTHER_WRITABLE?  Generally
 considered a bad idea." so trying to set a sysfs file writable for
 everyone will fail reverting to RO mode for "Others".
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 61d63c57bc2d..5b879bfea948 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -389,16 +389,4 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 # define REBUILD_DUE_TO_DYNAMIC_FTRACE
 #endif
 
-/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
-#define VERIFY_OCTAL_PERMISSIONS(perms)						\
-	(BUILD_BUG_ON_ZERO((perms) < 0) +					\
-	 BUILD_BUG_ON_ZERO((perms) > 0777) +					\
-	 /* USER_READABLE >= GROUP_READABLE >= OTHER_READABLE */		\
-	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 4) < (((perms) >> 3) & 4)) +	\
-	 BUILD_BUG_ON_ZERO((((perms) >> 3) & 4) < ((perms) & 4)) +		\
-	 /* USER_WRITABLE >= GROUP_WRITABLE */					\
-	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 2) < (((perms) >> 3) & 2)) +	\
-	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
-	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
-	 (perms))
 #endif
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 03a977168c52..281a006dc284 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -8,7 +8,7 @@
 #include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/stringify.h>
-#include <linux/kernel.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 
 /*
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c33a96b7391a..99b775f3ff46 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -808,4 +808,17 @@ static inline void sysfs_put(struct kernfs_node *kn)
 	kernfs_put(kn);
 }
 
+/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
+#define VERIFY_OCTAL_PERMISSIONS(perms)						\
+	(BUILD_BUG_ON_ZERO((perms) < 0) +					\
+	 BUILD_BUG_ON_ZERO((perms) > 0777) +					\
+	 /* USER_READABLE >= GROUP_READABLE >= OTHER_READABLE */		\
+	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 4) < (((perms) >> 3) & 4)) +	\
+	 BUILD_BUG_ON_ZERO((((perms) >> 3) & 4) < ((perms) & 4)) +		\
+	 /* USER_WRITABLE >= GROUP_WRITABLE */					\
+	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 2) < (((perms) >> 3) & 2)) +	\
+	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
+	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
+	 (perms))
+
 #endif /* _SYSFS_H_ */
-- 
2.43.0

