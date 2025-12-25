Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA8239E8B
	for <linux-modules@vger.kernel.org>; Thu, 25 Dec 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766682577; cv=none; b=Q7TJnST3ue8L8I9AAInMoa/t8dw9eHksaPKkPhva8I29Rj/2xmVGa1z5BG72t4gwtEiVGWAqb+hncprDZfwWvdncdN+P7ROpqi8Ds5AbbdTfjC2uJX54g8SJpMvQUWqPNuWc687W8i1Aq/BHhfibLaMjjy8fWOqid3M3j/D1jB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766682577; c=relaxed/simple;
	bh=w1WDwaBscjboIEZwjP8FVxLHs8ZbsMOX2p1cP0lc8Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6tmKkDUxPtqMDT/bDJtBN1i6iVxnfBFH0rAJAIzK4gTqTyI7fTAAYpsNiytxDQPstkX6sYAcntoTzddjKbNGVLJ5JoIR8Oe0ARGUsw3rHEM/0Nd5uqgdfks19HiivBc+fv6W9FDesgVkVGGBPGKBPIPJesnuV5y8g686ZxIEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbLNGWcD; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbLNGWcD"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6455a60c12bso6207800d50.3
        for <linux-modules@vger.kernel.org>; Thu, 25 Dec 2025 09:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766682575; x=1767287375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyNbxONE5FjE3NQ/ds0QsvOq9j9R5HrwQHi/I2IB5ps=;
        b=BbLNGWcDuXOLMIXhQ1/9iubWvEpPPTPlW7qQwhxiiiBQ0vSpdhsKlX1UNv1YC6viLw
         GYmzqiLeGFMoYB+/OPTK5tW+0zI7cUXRmlqO2yPRcRVUWfHoRYaptLMRHrOZsgrAe+87
         fe4jRAvVhgrQtHnr61DMXlropQ27Ol92FgSUsN6nN/HmHZxqxMIJ8syhHudTm32EVM4L
         u38l40Dscikos78qasw5G1+7khplvDNemfkmHsnc5iemYoywfN2BI4D1JiLnJHB3DxNO
         TUV2CGhXjRvDn18JpTxQb2FEKfTI84TZlyH7h41lrUHU2RvaBaC2+ii1fX1heyVopEGA
         8U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766682575; x=1767287375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyNbxONE5FjE3NQ/ds0QsvOq9j9R5HrwQHi/I2IB5ps=;
        b=RzsW5F20G7liLkzpHIH64c65Ast0ZltbFlmkCI6KfAUv2dUM5jRzhAHx8ugldkXk1W
         OL0iodHOZX98UXwYCwDPnoegwy1X5T3fycECesX55v0AckFoeamXJJZRFwmfrvLyKQPz
         2bKdbKVKFRRUwaDaJxmV/PQU1HA1reVzlkiUCYr9t0l+hx2LjLBjl9w9UqaWeNS83FUB
         fAsQkFu86TTtvOtPMQx3FAnrx4I2Bhk2C3NY1JHt9WysCYiOhSeFlKQJ3JcBnXplmPVy
         I58HlEYlHZ0ZmFCuWRE7MlFDpodXegFHerjZcaOg9pyP/YdZXLMGnrm+Y+EWmPkPb+1t
         Jr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdTV9z4BQ5aHb9cXZFYlNSG+5EU/LPJLACd1QI2ItuUYnCgOcdn4d9YV0XiWjBf28FCBiNFGVtkaDo3+xo@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5EmdL9mpF1pC4rRl1uPslgJl92v3yVX5JMKsIBsqK+/nhyKP
	rt0iW9w6j8p0SMYHnw7Zqtxntoi+UQ2/jgC/zXhqPFxNp8p4HDjq1sza
X-Gm-Gg: AY/fxX7H9ONAH8gW91sM9TIKC1cWDPWQMlnVNrk7y4J6aQvJ2Ua469B7KQB6UtP2PaF
	FQbVNw5OCEhFgl7Xvgv+MuhjfqsL0CrWbxP5iV2xN5GbqA1XBE0u9+59N9DYVyh71A7hgyRyT8n
	SgbERbLZB57k2TskFkjUrqO24Tynru3LiY7JnqqdzrQl0QbEUlwODv9IFZ/F8BySKdIyy4tPNYT
	y66g1sr06ERzRN/bl0PbLKytxk7SJR5GrLgpEVABi29pK1B8xeg6clo+NaunoOhrcQrGtBmqAJB
	+p9zikbMf5T1+UmkGNXEuXp9k6JN6mGfmvYT0n97Azqa3r5gHYcm6UvyibrN+DVEWkt3M9NtIp7
	QGDpKJo4XxKi1Z/EqiwixTrEXhTWPTA5UTOv5UznoeSTZ2cUuqx0q2mCrWRELus29sTzgtA2MmC
	BwBdNXUfJ3opffUEK5MA==
X-Google-Smtp-Source: AGHT+IFE8h6DvR/wQ+jE4yfmtCWCvhxSn9K0kIAiE1b9fgSbqcan4jtnrPelALLy8Mk/xvjxVHggUw==
X-Received: by 2002:a53:c5ca:0:b0:645:5467:29e7 with SMTP id 956f58d0204a3-6466a8b4e26mr13238687d50.24.1766682575137;
        Thu, 25 Dec 2025 09:09:35 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:5a70:118b:3656:4527])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f3f64sm75744107b3.27.2025.12.25.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:09:34 -0800 (PST)
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
Subject: [PATCH v4 2/7] moduleparam: include required headers explicitly
Date: Thu, 25 Dec 2025 12:09:24 -0500
Message-ID: <20251225170930.1151781-3-yury.norov@gmail.com>
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
index 915f32f7d888..03a977168c52 100644
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

