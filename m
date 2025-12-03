Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330835BDC9
	for <linux-modules@vger.kernel.org>; Wed,  3 Dec 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779017; cv=none; b=nbOOaaszZJq93zilIC06ko0VgDxewvtj+TN1o/gKJDIMpYcWfnBKIy1wTPlS3cBeMml+ZdrmEkrPYvK/tv00ZuFeBVUhC3vQaDcYVPvk5qd3N1P9NpILPrNJdeSSg6rs7ZvzgmgsiAaq4hMHje2VSY0gjqe+ynh8i0GhPAxxa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779017; c=relaxed/simple;
	bh=IZvatrejqQTMAZAs55HnDtJ6l1UGli2aSM/VGzyF64M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTSnzF5/1om+ErHUuimnqljUsR5Y6fPSZP0leKHR8zNOfsmDuZyDOHwLJVOIjZnxKS6G7fti6zRlZyDBnjF+v1QvaKSbfcbAkybC/DrNdJfGgrNfHO/K9LpyRXWHb4O4cfgpkmhFXPWYuxlQ24X8hAFy8EorACxCpSVVpuaB5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzxiy5Z3; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzxiy5Z3"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640e065991dso6151952d50.3
        for <linux-modules@vger.kernel.org>; Wed, 03 Dec 2025 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779014; x=1765383814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD9kPlC9NqK4/C2x8UYFTQBB7a0NtQWd16jS1I2SUnE=;
        b=Vzxiy5Z3syVFxXbv2YJu/n6ByE5xezc3Bc414Iqm2g3lBMqUeG5yqgwSwatHEWIyYh
         MbH7O6MmQfR4U+vhUX/r36k/nG0D7tZzf1n45wppm2RhGQbyCCEdzdcrWMnhx7aPN12k
         QI6a4ti0p+2RDuRfU9ZFTWXpE3O3wr/Gy0sG0bmgKa7MffWUe3EhDFamDprIHF3QrSWX
         vuM/WJ32wZxHhpuS5RZQjzUqdI3b1SIuFzQqEHvcejbLQU1ScN9tgQ3RWx47XVcq++xp
         g38fIDqDwkHoa/8y8AJnRCY/gO4sk8dDUdmUQkdtrHgbQTtLCA3CP0eVJQci8WcXP8Ol
         zQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779014; x=1765383814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BD9kPlC9NqK4/C2x8UYFTQBB7a0NtQWd16jS1I2SUnE=;
        b=F3n9nTAqRb9+Z4yi52Zc/KENXvPpPxXcHhmzThABFwPxeuj1uKFObZZQ72KzII1YUQ
         MWVBHvwW46zu+P5G+I/jZw3ZIYvQe9cLsQh9nsHI91Z2o7tHq5vSLQnu37wOrjFoyyxR
         ANYxbydpsnAKZ6ijvLgDmOayuxX84wAF57y5v4Vwk2gjpRNtoa3VK5MJTc3QODdlFnMt
         B8qzjLpGKF4QRxMqVYZmB2lL64XLpmxZL8DWxASFQUh2Qt6NCurt9wz/q+PPDE4mvlIq
         BwIw7wTXcTi+K3jQu429wVyGcwnaCVFQJolHUDYQ6fXJaXi/vDg4kFNS5Pyxome9+vKj
         RGpg==
X-Forwarded-Encrypted: i=1; AJvYcCXW23TNypMfhMoUPKTC3eDWOAREeFKU5OpzxkboviPH8TxVZyOn+MdcymMyVJ+XITZ6Bc9B4+65nV81IvhX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5t5DufZX26F5H62HqrzqAdkraCobP7xWu/PPVFVZVCsE3BqIX
	zBoGGlAhwBKHNfltQWf7vHDmvlQmZxStAedfQw5x3LCt7LYzvVEWCADr
X-Gm-Gg: ASbGncsNIIBJdPdv6iY+jNX3osESoM2IOtVcaVtMwUNNYUz4w6P/LdzPkQcoJ7Vg1YE
	58S/1gUIJonckx81IJEE8GaERupEnX3sY5uow/qVZOscwc6duLxPZ0sKbttUQtZ6fn2NHMKYbxT
	xFjTV86JNjgIjHN1a68k7N+dBFcbgDz8jkqSxz3MeXbkZg5yvDDbi/9GtKAz9kPBW+8BfMJ7bOd
	uw3jAnW1tx28jYXTX4am7TwYe5PSzsH/hlyO9JFYFcbqXACV+0rltdx9mUj1D5crQw9AqcFh5ao
	wVYQ/qLNzmZnK79++iPGOzuKU/0UEFZw38ypmnYwHN9jwJUy5RR38QmsGBZ6QcoQ8TzPjDppVht
	G5oPXWkyVGytol2b6vxFyrON/4I2If8ZZfW85SBqXpSabojOMThSlu4wiu6Qd2RgBitcpRomh4q
	ixIs0CShVL1adWd1Y2vg==
X-Google-Smtp-Source: AGHT+IED9MOFMxvYSeb8SzBPTCp8AtkRM45d5US6WkMtf3ZGLjHaRGAjGtBn2tkqfezw7s+564T5/Q==
X-Received: by 2002:a05:690e:134a:b0:640:caa5:57bf with SMTP id 956f58d0204a3-64436fab865mr2201474d50.24.1764779014070;
        Wed, 03 Dec 2025 08:23:34 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c089431sm7456743d50.10.2025.12.03.08.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:23:33 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v2 3/4] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Date: Wed,  3 Dec 2025 11:23:24 -0500
Message-ID: <20251203162329.280182-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203162329.280182-1-yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
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
index ca7c8107c7c8..dd2d990b2611 100644
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
index 9a25a2911652..15ee3ef33991 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -798,4 +798,17 @@ static inline void sysfs_put(struct kernfs_node *kn)
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

