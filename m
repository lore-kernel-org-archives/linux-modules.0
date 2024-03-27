Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506612A141
	for <linux-modules@vger.kernel.org>; Wed, 27 Mar 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549151; cv=none; b=ECcV2UxLuca5vZ6sHp97yHKS1fFNi11SvMCX5869yBMbJDNRUu4hXm7xdMY4dIv5KXPILBsd5s7rAskKHXSyWxnaQQJD8weR+nYDDbKhwMUT6AR6LFfKzhkQ8BG6dDkxz3BD3Jzn5riH2ai5tZpbrKA2zIWKI/9/iWI9Lq4x8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549151; c=relaxed/simple;
	bh=0kLLmMw4/O3TBBKUsgSTgaWCMt15z0cmnYLnE3Bkir0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdLTr8qIdnhx0r3VvesjMZedmGp5TJWbmxb/qgd6rGOwdx/ZWiCnekzUIyw3lHAkHRfBR3fXGEp5SqQ5wr27JY/w5dAu3to5F9i8QapLbJ5eodG9DTgJ/qgWDaOAYqnHAsiG2z2jp0uQ48k3xQ1KbqyW15j0+4UZSnCUqdnyzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lt6vteYM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lt6vteYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711549149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hvGCD2+uFOob7s7i2B6yFil+RKwQBprVcC67jRXTkM=;
	b=Lt6vteYM//mGwwlWewK/gSLuWbRSnZI8lFGb/QMhFr97gx+P79ulrwoAkDp7XHMsrB5+Wq
	HYRw9vMeamMQTgRlNHUgFq7d0dRhqFnmXJJjbkh0n+ifWQz9/zmze6BjXgLE+/fP2p8vwl
	9obzV9FARS7oCOeuKHqV6a2T053Ezfs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-Ympw0WwQMLuE7hsl_qTVGw-1; Wed,
 27 Mar 2024 10:19:07 -0400
X-MC-Unique: Ympw0WwQMLuE7hsl_qTVGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2C8928B6982;
	Wed, 27 Mar 2024 14:19:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ACF1D1121312;
	Wed, 27 Mar 2024 14:19:04 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com,
	mcgrof@kernel.org
Cc: emil.velikov@collabora.com,
	gustavo.sousa@intel.com,
	jtornosm@redhat.com,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	md@linux.it
Subject: [PATCH] module: create weak dependecies
Date: Wed, 27 Mar 2024 15:18:57 +0100
Message-ID: <20240327141857.98026-1-jtornosm@redhat.com>
In-Reply-To: <7vowjj4oo64a2vquvqaszmzcdvbrlkntcze2btnogvkwwtuddv@uz72wpi2t55s>
References: <7vowjj4oo64a2vquvqaszmzcdvbrlkntcze2btnogvkwwtuddv@uz72wpi2t55s>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

It has been seen that for some network mac drivers (i.e. lan78xx) the
related module for the phy is loaded dynamically depending on the current
hardware. In this case, the associated phy is read using mdio bus and then
the associated phy module is loaded during runtime (kernel function
phy_request_driver_module). However, no software dependency is defined, so
the user tools will no be able to get this dependency. For example, if
dracut is used and the hardware is present, lan78xx will be included but no
phy module will be added, and in the next restart the device will not work
from boot because no related phy will be found during initramfs stage.

In order to solve this, we could define a normal 'pre' software dependency
in lan78xx module with all the possible phy modules (there may be some),
but proceeding in that way, all the possible phy modules would be loaded
while only one is necessary.

The idea is to create a new type of dependency, that we are going to call
'weak' to be used only by the user tools that need to detect this situation.
In that way, for example, dracut could check the 'weak' dependency of the
modules involved in order to install these dependencies in initramfs too.
That is, for the commented lan78xx module, defining the 'weak' dependency
with the possible phy modules list, only the necessary phy would be loaded
on demand keeping the same behavior, but all the possible phy modules would
be available from initramfs.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 include/linux/module.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 1153b0d99a80..231e710d8736 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -173,6 +173,11 @@ extern void cleanup_module(void);
  */
 #define MODULE_SOFTDEP(_softdep) MODULE_INFO(softdep, _softdep)
 
+/* Weak module dependencies. See man modprobe.d for details.
+ * Example: MODULE_WEAKDEP("module-foo")
+ */
+#define MODULE_WEAKDEP(_weakdep) MODULE_INFO(weakdep, _weakdep)
+
 /*
  * MODULE_FILE is used for generating modules.builtin
  * So, make it no-op when this is being built as a module
-- 
2.44.0

