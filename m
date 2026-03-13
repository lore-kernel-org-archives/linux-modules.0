Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86A394797
	for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409791; cv=none; b=jVsMVlB3cJw32JSBFKZGS60pIrcrjquj9sC8SwdFncUub0GvrXY3KaJImYf9O+GEHDwAvV+VYAV0KyZ1Gx7rJCknDTl7uuecmZsTYeNf+uaMjuZ3TLkzmNJguD65r4tJCY+rl1Et88HqWlozADshm3pRtOLStTWnHg0A7B/Ops4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409791; c=relaxed/simple;
	bh=qruJx6QJEICr8bcneKcKb3mtFa1KqnHncYpYtjLmF5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbATgxOmHJ2vv1lw5DBo5XepyQ4b5DVtaoHvSDrGt7+2sFTKWNs0E0k8LMvwC6K2FjJNKlYEqKJwR/SUd7kutBWwhOXLhYvaNrqKcB5CRt2hhg/3YIjf60r8OgU1tzM7JSsEk6ciNe3SihT95u0+4r+J+Rz6y6w+sfTcgeU3IOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TZEnpjWv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TZEnpjWv"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48540355459so19334895e9.3
        for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773409787; x=1774014587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGEtKP4Tr+bgxoNWP/aiQM4tyqyPY7Jg/v7bcyDwq6Y=;
        b=TZEnpjWvwF6duicvrRlAYvuTw2tYpLZaeuwBaSwQiuBsqdXAYCUQ9HOvN0xx7jccEN
         6uLUOuGONLudTigIEXxX8vOsaHdB6AgqLxYV+FtYoYac0SqYM6PrkUNiDYzpUzVm09hi
         odR88dJ6kifIf/q4G2cGtk2ojnshlwwxmwAPkozLY8qzsu+8pID1Nyoh+D7cG/AyeqST
         1XFKnDwNTwpZMNRVn6xfTPV2vF3zfdjuutETDWbCBktxlAL3B1RX1w9GTaOS9tIUqu6G
         MSmunzu/FGdJ7eAdhfw7YESrB5H9z58e2RK/bNnUk/zCfivV3LGtF/sfQ6ve4H7TcJiq
         znpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409787; x=1774014587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGEtKP4Tr+bgxoNWP/aiQM4tyqyPY7Jg/v7bcyDwq6Y=;
        b=hGtKpuYA5lYMGLGvHziwft6DYljo4j9y9Gni5UcyEs7iHr7MjERpIYo4zCewGeiwRQ
         eT0nkoaii7YHeKNlv7QvHHeQ8WkvmIrGgQNV+qPOeefA+6DNzmbqutn66S7O3DBTuMUQ
         mbpQG39WbX+WsDUctuuENq5Jq/mSOj9jy3Bk+nOSpoIrcLo1rzfMkIas6AfaVAEm1ysu
         8geZftYjYqz+T+3PkSyKfAve+lzQgGJfZyr4XCdXwXf0zcX1Kg4/MB7N6KWe7XlFnWq2
         Eh6qC2IOd95IF6nnknjx8gpNulFsa5s1iRxZYGuFEdvQoCyAGL+UxoFSwS6KuC/j+CJQ
         ra8w==
X-Forwarded-Encrypted: i=1; AJvYcCXb0TzgRbclvZeIiGXAf5Ss3ULEnrP7OGItkhDKDrH6xz+FoEkdU1lZviqZgYKd02NPVm9osASVeLi8JT/X@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8dgu0BJIlZwTg5ynVrYgsdZoHwV98aPEa9vILYx8R1kvw0rV
	KKHw6Co8ghSmuN7KAaj0t12TQIPk5rfNRUMfw2387Mqe1yLDcuhXN6jZOGk9uFiMYu8=
X-Gm-Gg: ATEYQzyym7YRGBww20qLQCP5cm5xp71CRQ8fUL5e2OYjpyj2hcgrkQhSpOEaht5/fr5
	8tleDHTSRY3zqogD2eh6Z1NZ88Ni4IAyRuH4JiZ7unNxWl36wTdvMcMwmuh+bwkfWNUY3NzQ/sk
	Rj4XP9UFpzn/+QERPib/JEOQPvcznZpdih447BjUCh871Bf1RoNaZtBv8a/cU/KAWV3JkLe+eTY
	l7NJimrlxpCUnFK7VIGxDZ95whvlLPYm4YiiYxUGqwrq49oqy3KX3aM0IEAvkt2kXeD4bmiahCq
	woJCZ6XEOFT654MfGRD6qVJtcNey/yyXypP+X84P1Hnn4bdiEQcHUlarv9R4y3/gyjwIpJwkiTf
	7CSpABzEXAc3Low0VYawIAhomH+XBlRRMJ3xtbDAU0TjO5Eei4bd+nYGFu3zLk0IwVfp6y3Ah4n
	9BWDv3zC1UXS/yQHEcdS7LsOyhLwPsanW/ipjgSMtQ
X-Received: by 2002:a05:600c:8b6f:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-485566d92f3mr54669825e9.10.1773409787280;
        Fri, 13 Mar 2026 06:49:47 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm206491865e9.14.2026.03.13.06.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:49:47 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] module: Remove extern keyword from param prototypes
Date: Fri, 13 Mar 2026 14:48:04 +0100
Message-ID: <20260313134932.335275-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313134932.335275-1-petr.pavlu@suse.com>
References: <20260313134932.335275-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The external function declarations do not need the "extern" keyword. Remove
it to align with the Linux kernel coding style and to silence the
associated checkpatch warnings.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/moduleparam.h | 89 ++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 604bc6e9f3a1..075f28585074 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -317,8 +317,8 @@ struct kparam_array
 			    name, &__param_ops_##name, arg, perm, -1, 0)
 
 #ifdef CONFIG_SYSFS
-extern void kernel_param_lock(struct module *mod);
-extern void kernel_param_unlock(struct module *mod);
+void kernel_param_lock(struct module *mod);
+void kernel_param_unlock(struct module *mod);
 #else
 static inline void kernel_param_lock(struct module *mod)
 {
@@ -398,7 +398,7 @@ static inline void kernel_param_unlock(struct module *mod)
  * Returns: true if the two parameter names are equal.
  * Dashes (-) are considered equal to underscores (_).
  */
-extern bool parameq(const char *name1, const char *name2);
+bool parameq(const char *name1, const char *name2);
 
 /**
  * parameqn - checks if two parameter names match
@@ -412,18 +412,18 @@ extern bool parameq(const char *name1, const char *name2);
  * are equal.
  * Dashes (-) are considered equal to underscores (_).
  */
-extern bool parameqn(const char *name1, const char *name2, size_t n);
+bool parameqn(const char *name1, const char *name2, size_t n);
 
 typedef int (*parse_unknown_fn)(char *param, char *val, const char *doing, void *arg);
 
 /* Called on module insert or kernel boot */
-extern char *parse_args(const char *doing,
-		      char *args,
-		      const struct kernel_param *params,
-		      unsigned int num,
-		      s16 min_level,
-		      s16 max_level,
-		      void *arg, parse_unknown_fn unknown);
+char *parse_args(const char *doing,
+		 char *args,
+		 const struct kernel_param *params,
+		 unsigned int num,
+		 s16 min_level,
+		 s16 max_level,
+		 void *arg, parse_unknown_fn unknown);
 
 /* Called by module remove. */
 #ifdef CONFIG_MODULES
@@ -437,78 +437,77 @@ void module_destroy_params(const struct kernel_param *params, unsigned int num);
 	static inline type __always_unused *__check_##name(void) { return(p); }
 
 extern const struct kernel_param_ops param_ops_byte;
-extern int param_set_byte(const char *val, const struct kernel_param *kp);
-extern int param_get_byte(char *buffer, const struct kernel_param *kp);
+int param_set_byte(const char *val, const struct kernel_param *kp);
+int param_get_byte(char *buffer, const struct kernel_param *kp);
 #define param_check_byte(name, p) __param_check(name, p, unsigned char)
 
 extern const struct kernel_param_ops param_ops_short;
-extern int param_set_short(const char *val, const struct kernel_param *kp);
-extern int param_get_short(char *buffer, const struct kernel_param *kp);
+int param_set_short(const char *val, const struct kernel_param *kp);
+int param_get_short(char *buffer, const struct kernel_param *kp);
 #define param_check_short(name, p) __param_check(name, p, short)
 
 extern const struct kernel_param_ops param_ops_ushort;
-extern int param_set_ushort(const char *val, const struct kernel_param *kp);
-extern int param_get_ushort(char *buffer, const struct kernel_param *kp);
+int param_set_ushort(const char *val, const struct kernel_param *kp);
+int param_get_ushort(char *buffer, const struct kernel_param *kp);
 #define param_check_ushort(name, p) __param_check(name, p, unsigned short)
 
 extern const struct kernel_param_ops param_ops_int;
-extern int param_set_int(const char *val, const struct kernel_param *kp);
-extern int param_get_int(char *buffer, const struct kernel_param *kp);
+int param_set_int(const char *val, const struct kernel_param *kp);
+int param_get_int(char *buffer, const struct kernel_param *kp);
 #define param_check_int(name, p) __param_check(name, p, int)
 
 extern const struct kernel_param_ops param_ops_uint;
-extern int param_set_uint(const char *val, const struct kernel_param *kp);
-extern int param_get_uint(char *buffer, const struct kernel_param *kp);
+int param_set_uint(const char *val, const struct kernel_param *kp);
+int param_get_uint(char *buffer, const struct kernel_param *kp);
 int param_set_uint_minmax(const char *val, const struct kernel_param *kp,
 		unsigned int min, unsigned int max);
 #define param_check_uint(name, p) __param_check(name, p, unsigned int)
 
 extern const struct kernel_param_ops param_ops_long;
-extern int param_set_long(const char *val, const struct kernel_param *kp);
-extern int param_get_long(char *buffer, const struct kernel_param *kp);
+int param_set_long(const char *val, const struct kernel_param *kp);
+int param_get_long(char *buffer, const struct kernel_param *kp);
 #define param_check_long(name, p) __param_check(name, p, long)
 
 extern const struct kernel_param_ops param_ops_ulong;
-extern int param_set_ulong(const char *val, const struct kernel_param *kp);
-extern int param_get_ulong(char *buffer, const struct kernel_param *kp);
+int param_set_ulong(const char *val, const struct kernel_param *kp);
+int param_get_ulong(char *buffer, const struct kernel_param *kp);
 #define param_check_ulong(name, p) __param_check(name, p, unsigned long)
 
 extern const struct kernel_param_ops param_ops_ullong;
-extern int param_set_ullong(const char *val, const struct kernel_param *kp);
-extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
+int param_set_ullong(const char *val, const struct kernel_param *kp);
+int param_get_ullong(char *buffer, const struct kernel_param *kp);
 #define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
 
 extern const struct kernel_param_ops param_ops_hexint;
-extern int param_set_hexint(const char *val, const struct kernel_param *kp);
-extern int param_get_hexint(char *buffer, const struct kernel_param *kp);
+int param_set_hexint(const char *val, const struct kernel_param *kp);
+int param_get_hexint(char *buffer, const struct kernel_param *kp);
 #define param_check_hexint(name, p) param_check_uint(name, p)
 
 extern const struct kernel_param_ops param_ops_charp;
-extern int param_set_charp(const char *val, const struct kernel_param *kp);
-extern int param_get_charp(char *buffer, const struct kernel_param *kp);
-extern void param_free_charp(void *arg);
+int param_set_charp(const char *val, const struct kernel_param *kp);
+int param_get_charp(char *buffer, const struct kernel_param *kp);
+void param_free_charp(void *arg);
 #define param_check_charp(name, p) __param_check(name, p, char *)
 
 /* We used to allow int as well as bool.  We're taking that away! */
 extern const struct kernel_param_ops param_ops_bool;
-extern int param_set_bool(const char *val, const struct kernel_param *kp);
-extern int param_get_bool(char *buffer, const struct kernel_param *kp);
+int param_set_bool(const char *val, const struct kernel_param *kp);
+int param_get_bool(char *buffer, const struct kernel_param *kp);
 #define param_check_bool(name, p) __param_check(name, p, bool)
 
 extern const struct kernel_param_ops param_ops_bool_enable_only;
-extern int param_set_bool_enable_only(const char *val,
-				      const struct kernel_param *kp);
+int param_set_bool_enable_only(const char *val, const struct kernel_param *kp);
 /* getter is the same as for the regular bool */
 #define param_check_bool_enable_only param_check_bool
 
 extern const struct kernel_param_ops param_ops_invbool;
-extern int param_set_invbool(const char *val, const struct kernel_param *kp);
-extern int param_get_invbool(char *buffer, const struct kernel_param *kp);
+int param_set_invbool(const char *val, const struct kernel_param *kp);
+int param_get_invbool(char *buffer, const struct kernel_param *kp);
 #define param_check_invbool(name, p) __param_check(name, p, bool)
 
 /* An int, which can only be set like a bool (though it shows as an int). */
 extern const struct kernel_param_ops param_ops_bint;
-extern int param_set_bint(const char *val, const struct kernel_param *kp);
+int param_set_bint(const char *val, const struct kernel_param *kp);
 #define param_get_bint param_get_int
 #define param_check_bint param_check_int
 
@@ -615,19 +614,19 @@ enum hwparam_type {
 extern const struct kernel_param_ops param_array_ops;
 
 extern const struct kernel_param_ops param_ops_string;
-extern int param_set_copystring(const char *val, const struct kernel_param *);
-extern int param_get_string(char *buffer, const struct kernel_param *kp);
+int param_set_copystring(const char *val, const struct kernel_param *kp);
+int param_get_string(char *buffer, const struct kernel_param *kp);
 
 /* for exporting parameters in /sys/module/.../parameters */
 
 struct module;
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_MODULES)
-extern int module_param_sysfs_setup(struct module *mod,
-				    const struct kernel_param *kparam,
-				    unsigned int num_params);
+int module_param_sysfs_setup(struct module *mod,
+			     const struct kernel_param *kparam,
+			     unsigned int num_params);
 
-extern void module_param_sysfs_remove(struct module *mod);
+void module_param_sysfs_remove(struct module *mod);
 #else
 static inline int module_param_sysfs_setup(struct module *mod,
 			     const struct kernel_param *kparam,
-- 
2.53.0

