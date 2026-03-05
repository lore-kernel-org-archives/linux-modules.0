Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655333688A
	for <linux-modules@vger.kernel.org>; Thu,  5 Mar 2026 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675569; cv=none; b=kJqayIx6X5kX+PwVAAs6qF46h9PjANGH5IL89ZNvdXObC7r76q/ivMk90O/eR/W7XPHFgiROmEjdwcntXOXS4VEnhZSxbr9lcEZyzsIfJAij8NHZVUuEGIrOjpLaFtotZrqWP0nbC2iEXV+CFkjfRvV43djjOHPheAbTEGhu8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675569; c=relaxed/simple;
	bh=5+sPssbX4DjNgiCHhK+7R9HB8TbI96p5oZyAfzKul4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=U1kcBzhkvIyOUyJBUPtVSfycgUkDYMW+G8Tyz6bMDW2UHsLavb1wzb7iY4dKckeav+Q0970ZmBNKYBtIbCXoJfHnnUGf8vHnm5TWWTCLR3QL8Nukh/uGisutEaQk8xdTe2k6bJ1LlJaZuz+ifyQtHwdNZgDUBje6qv06EgjEFEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgSvd/bx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgSvd/bx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772675566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8aprwNHpfwhGWqO3GQWsFAasnh0wuwj6x6k2vz+M2hM=;
	b=dgSvd/bx1PCAJIhWvPO7GTFQbbOBDjYDVjHOeMAkEMk9KYnjbN7PYcsq1EoC3UshWiEiXt
	5iYDwI0tO2l6WFAtB2axfg0oc8HBDmmZFH23WJK59WueD8wNdD/wLsq9MFDMkMI+Hcrens
	HAdXY1qB2KpDGb23x8ZdxzQC4qliCLw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-RknQHbo4PceER0PBFO4fVQ-1; Wed,
 04 Mar 2026 20:52:44 -0500
X-MC-Unique: RknQHbo4PceER0PBFO4fVQ-1
X-Mimecast-MFC-AGG-ID: RknQHbo4PceER0PBFO4fVQ_1772675563
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1240180049D;
	Thu,  5 Mar 2026 01:52:42 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0178C180035F;
	Thu,  5 Mar 2026 01:52:40 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Petr Mladek <pmladek@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v2] module.lds,codetag: force 0 sh_addr for sections
Date: Wed,  4 Mar 2026 20:52:37 -0500
Message-ID: <20260305015237.299727-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
related macros") added .text and made .data, .bss, and .rodata sections
unconditional in the module linker script, but without an explicit
address like the other sections in the same file.

When linking modules with ld.bfd -r, sections defined without an address
inherit the location counter, resulting in non-zero sh_addr values in
the .ko.  Relocatable objects are expected to have sh_addr=0 for these
sections and these non-zero addresses confuse elfutils and have been
reported to cause segmentation faults in SystemTap [1].

Add the 0 address specifier to all sections in module.lds, including the
.codetag.* sections via MOD_SEPARATE_CODETAG_SECTIONS macro.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958
Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 include/asm-generic/codetag.lds.h |  2 +-
 scripts/module.lds.S              | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

v2:
- Update the MOD_SEPARATE_CODETAG_SECTION for .codetag.* as well [Petr]

v1: https://lore.kernel.org/lkml/20260304160611.143862-1-joe.lawrence@redhat.com

diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
index a14f4bdafdda..4948e5d4e9d9 100644
--- a/include/asm-generic/codetag.lds.h
+++ b/include/asm-generic/codetag.lds.h
@@ -18,7 +18,7 @@
 	IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(alloc_tags))
 
 #define MOD_SEPARATE_CODETAG_SECTION(_name)	\
-	.codetag.##_name : {			\
+	.codetag.##_name 0 : {			\
 		SECTION_WITH_BOUNDARIES(_name)	\
 	}
 
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 054ef99e8288..e1cab3cee3f7 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -32,30 +32,30 @@ SECTIONS {
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
 	__ex_table		0 : ALIGN(4) { KEEP(*(__ex_table)) }
 
-	__patchable_function_entries : { *(__patchable_function_entries) }
+	__patchable_function_entries 0 : { *(__patchable_function_entries) }
 
 	.init.klp_funcs		0 : ALIGN(8) { KEEP(*(.init.klp_funcs)) }
 	.init.klp_objects	0 : ALIGN(8) { KEEP(*(.init.klp_objects)) }
 
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
-	__kcfi_traps		: { KEEP(*(.kcfi_traps)) }
+	__kcfi_traps		0 : { KEEP(*(.kcfi_traps)) }
 #endif
 
-	.text : {
+	.text			0 : {
 		*(.text .text.[0-9a-zA-Z_]*)
 	}
 
-	.bss : {
+	.bss			0 : {
 		*(.bss .bss.[0-9a-zA-Z_]*)
 		*(.bss..L*)
 	}
 
-	.data : {
+	.data			0 : {
 		*(.data .data.[0-9a-zA-Z_]*)
 		*(.data..L*)
 	}
 
-	.rodata : {
+	.rodata			0 : {
 		*(.rodata .rodata.[0-9a-zA-Z_]*)
 		*(.rodata..L*)
 	}
-- 
2.53.0

