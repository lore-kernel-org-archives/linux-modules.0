Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD61397
	for <linux-modules@vger.kernel.org>; Fri,  5 Dec 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957165; cv=none; b=Wr3axQhtVsJFLNAtk/xe0MCX7mCvclrm+ABOVcRM5dvnawXqXh29kif/DIvMOSs1sPHSEq2+vSUgNAIFxQPXPWOM7GHwkFUrldtgnfsukg4jS8JdFwlHTgfyUzf1y/BUlpBlNe4hUfxWl0VWUqQ2gMpGQsyyxRs/MmxAWRqCFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957165; c=relaxed/simple;
	bh=WSOyLaVAbG8nPsi8Fh9vJNEZaG1V5dArA0Vg97NjEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnt92+/AdXdpqgke+6yNND8jcidK/KE34O4BF9iyg589QlluL8RNQlqTEBC9Fggopeds2Vi0nDo+j11nQVy1hO+ldONRonyQ0ElQjuFglwJR+n2s15udk6WBzlExiTJb5MOVcdgkcNqNhFx9fJXdIIH785fiTelO0MzwePM22zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJnkwzYQ; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJnkwzYQ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64306a32ed2so2133391d50.2
        for <linux-modules@vger.kernel.org>; Fri, 05 Dec 2025 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957161; x=1765561961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgVl4UPQOdVuiUQDADihFeO6bzjnbrTXUsfv7qld2JA=;
        b=dJnkwzYQfklN6TTaAJuQ16YzRJmHq+jURTpxoQvIIW1FMEKONaWFcFiYjt0swVjt+A
         zr0hYyYIWXpWT3MLcL7kPDXDEmw1dzGUlpDgpdNVyPhJsKLh7ickV28HCqTZR5sn+y/9
         b2NcGaQEK4/5yDhH+SulYSio94HPbfMhHSjKVdMMVu1Cqk5Z5QQsWMQl+T7v0zVU4k24
         wI0jGFaMtRGhFzQw1DFo1Vy1Z5cegY/xUeHb346U+sA4mCpvhjkuRbFqz3hxWCRZXixo
         PA/HxOc77rlsIoXoQxbmwi1IhcZ4OOEarFU+si7/29hdfWCPTzFBpbmgjYdHMtdJ2Eza
         /osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957161; x=1765561961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgVl4UPQOdVuiUQDADihFeO6bzjnbrTXUsfv7qld2JA=;
        b=qHP97YE4PBcWR5i7Fa/2esqmKZdfUgmK8waw0u1G+8T+0ycsPKd7hkHtNy9WSXyFA/
         Cp4zE3vXRTKZ3/DAHAwbLelukiBE4W5TZ6M9qiWGt+iHGp+Cord32qrMKtzQiREt7o+B
         v+zm8MrPMCsZa8sYwekFud0+ZZfjwzcDIe+3PqMuHVP772qCh5UD/4EleoVVQvIjRfY8
         UFIVfyp/us/+g7mmSeh8TXiySMAkmhwf9XWtFaT8lesItYPBvtZNGXnVYVHVi4cwzRpt
         LvFfEmng+o44HRbkO4m3jWjdN7kaXtUskhPuccbRDK7OpNaybsPrB9V5LH/aqMKVH95Z
         a2uA==
X-Forwarded-Encrypted: i=1; AJvYcCXOGyqn6t4+6o8Yhm6VGoPS5QFZ6/OO7WiL1uIfFgnfILNLK+U5oST0mFqAP8bBOLVDlye+ud8NSAPhpgGD@vger.kernel.org
X-Gm-Message-State: AOJu0YwFaWDcqSgggmAAB4WnglVuB9P21Qh4ITK8rq3H0dkHs7WMxZxL
	Q3hijOYSfQ60J3o3sZqJBGlAqD/9Ib5NrCEfTyl9TweGFn6j+/kVthuP
X-Gm-Gg: ASbGnctVsLXNJQotHfi0IikSyBKxVMiaAUaj3Ioyakdh6dVt2wVY4+TWV8F1cFKR5bZ
	gXOBpDGWSBCMP3JJaMuYi/4mCKj06Hb97VrSNCZM8J5bQggrLnYtFqaHEMSmYFH4yoI1Q9Q36HV
	zWBoR3+3Dbew75YRNxWHs7OT5ntvkmnF1Q1nQi9RoDZ61yGOLHhs+cxhPWruMgEulcJRea0M8OY
	saRXl9LVldTLb1e/xaSvttGpiyz7xvqR/oZ4joyEEjDOvFEcjbXg3ygIQ3MQ65OxOq8d8xDNgW7
	7giVLZLvLKto6DPeOpC86toPPUzSPnaRAoyBJ1EBHhIAQhN1147uv+D/Tim8wJaa9ObLFX0yprd
	zPsIJirGYLHK1MS1r9jWnJpMHCS3+zZnawh8m1tNCLe17F7Ci2WOoZvkcLMgaKcKfWsIz5V9vPt
	vnN4yv/CsU1tCaSZSp
X-Google-Smtp-Source: AGHT+IEmHQrMAc5KhCOB44tPj+C3L7ufMqCejlU3WOz8uzACjmQ1s89nXnFrR9N4AEaBc1g4PgKHgQ==
X-Received: by 2002:a05:690c:4f12:b0:78c:2803:c819 with SMTP id 00721157ae682-78c2803ceb0mr17790807b3.22.1764957160598;
        Fri, 05 Dec 2025 09:52:40 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:be2a:7e4d:3bf:3fbc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b779458sm18946927b3.35.2025.12.05.09.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:52:40 -0800 (PST)
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
Subject: [PATCH v3 2/4] moduleparam: include required headers explicitly
Date: Fri,  5 Dec 2025 12:52:33 -0500
Message-ID: <20251205175237.242022-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205175237.242022-1-yury.norov@gmail.com>
References: <20251205175237.242022-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patch drops moduleparam.h dependency on kernel.h. In
preparation to it, list all the required headers explicitly.

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/moduleparam.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 6907aedc4f74..ca7c8107c7c8 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -2,9 +2,14 @@
 #ifndef _LINUX_MODULE_PARAMS_H
 #define _LINUX_MODULE_PARAMS_H
 /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
+
+#include <linux/array_size.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/stringify.h>
 #include <linux/kernel.h>
+#include <linux/types.h>
 
 /*
  * The maximum module name length, including the NUL byte.
-- 
2.43.0

