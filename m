Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440814B06E
	for <linux-modules@vger.kernel.org>; Thu,  9 May 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715250297; cv=none; b=a0N+hIE+nYFRhf1nWT3C+XEEYk0PDSEgjFPVwQ/WfN+934SVO1Q2ZQrBIccNnjJq80hBp92NxJt6VC/tfRyBq3rVwDie6hbjQLQPvc8msaeBRx041XNSOCGYXJz1WOaklgGZnPLrnL1CNnuT2PU4QzdxV4PdRhoGdSk8jYkCwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715250297; c=relaxed/simple;
	bh=pbFU41RJ6FcZOxKZe+Ud+0dEC/T1KjTODn5fDzyhkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKko7OrSBGZJxldjXaOg/KJMxQxYC9ceP4JOH7L5+mDoFNsq4Tm+woY17HnU3EJn/+dbKNJvuvECZuuU7J7MRxLgVObURuPUEdcs62lB+Y8sQ9fon0uHqdqhpwu4njrhHc5HWeQauvDUhT/Qu7BHTlZQsAWsKryenbI/rNjutLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcGnC3jm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcGnC3jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715250294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7zHc7fs9O/huou8M4UloljeK6K5aZsWXnMgzdP+3PJ8=;
	b=QcGnC3jmWv8UKdH7fU1q/7IX32YqJ/6+5GQS24pY1s06aRhZL6qwXlq6PKGS79T6OB7UGO
	twEu86QhKAimU9aBPU1QVdyLACwF66afSPB/zLUsT/jDZN+hm+CV3fmrFRlRT2VF5ZK0np
	rSbNxUKVCkf0N5CMGspFISbmymgGMrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-PfHLc4ubOxasLZxexH-nBw-1; Thu, 09 May 2024 06:24:51 -0400
X-MC-Unique: PfHLc4ubOxasLZxexH-nBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 517E3101A525;
	Thu,  9 May 2024 10:24:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C38BC36EC;
	Thu,  9 May 2024 10:24:49 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: mcgrof@kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lucas.demarchi@intel.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v2] module: create weak dependecies
Date: Thu,  9 May 2024 12:24:40 +0200
Message-ID: <20240509102442.176958-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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

The 'weak' dependency support has been included in kmod:
https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Include reference to 'weak' dependency support in kmod.

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

