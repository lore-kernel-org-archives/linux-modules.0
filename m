Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A0289E13
	for <linux-modules@vger.kernel.org>; Wed, 12 Nov 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957312; cv=none; b=ea+STqNPhVA8EgXoN+I5+Qeo/rRrPJ/VgaBDF1OQsRrGSpRLkNfowZdfRq0OP2FgWOV2piFv5TNziFgh9pIrDsEoTZGgACtax/wBP61X/x+m2MN3X91ioSmdqEKC95LkSi0PHoOqZPnnXXee0BM9XL2EC0SYIYghnKJ9EV9hIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957312; c=relaxed/simple;
	bh=DErfb1yw71TjXX1m2fEvBmVvRDvk5oiZa5z6kIuTRKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDSwnzqEUBaoglsILG1bZh4rV6WLx+PlASGnLo3sMi7n6FUKsRqMCNwQYU0j7EYMg7Fe49MmbxKds8b/nGgVtCMzpoCEZYKXysoI0f96vWSww1YJhr6eimmk77VxGbyT1kDJO/SDGtcv603kaNnfB08xnKy2XYlDMu5IUYi1CwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fwm4E1Ut; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ek/OUc1L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fwm4E1Ut";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ek/OUc1L"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id E2A561F807;
	Wed, 12 Nov 2025 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97I/A52s9/abeslkIlgFB5lHhNmcwVQr9GlDloyKxh0=;
	b=Fwm4E1Utf5nc5WoVAJu8cPbGqYJ663EAiMUr/dgD+haLJtJDSIcHPLVCstP0e3WjSOyVfL
	39XTW3sBJh9rrJpBYxUGdJ/vEbrIGUF1xbftuqISTH9XzIGuFllUp4K1p6cRVP8z78xg9G
	Lx9r2Hkyv/iU1gSYpAnO1AI1iHmlcxs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97I/A52s9/abeslkIlgFB5lHhNmcwVQr9GlDloyKxh0=;
	b=ek/OUc1L8yezFuEAGDJzTqJ+8mCV7yLr5PfXO+bwcp0xVnqW4RJjJ6UsOksg2or/65hKKb
	GF94DTt31+xP9WOXSka14/oe6F8IQ9cgWvXrVP3QKtCUe6Ax86F4RO8qb3QVsNLhyD24xm
	8u8FIpZ5z2VqK5lcE6vsJa0kgttZ0Go=
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 7/7] kallsyms: Prevent module removal when printing module name and buildid
Date: Wed, 12 Nov 2025 15:20:03 +0100
Message-ID: <20251112142003.182062-8-pmladek@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112142003.182062-1-pmladek@suse.com>
References: <20251112142003.182062-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:email,pathway.suse.cz:helo];
	R_RATELIMIT(0.00)[to_ip_from(RLw9bydq1j5bti46rxed9sjz7y)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 

kallsyms_lookup_buildid() copies the symbol name into the given buffer
so that it can be safely read anytime later. But it just copies pointers
to mod->name and mod->build_id which might get reused after the related
struct module gets removed.

The lifetime of struct module is synchronized using RCU. Take the rcu
read lock for the entire __sprint_symbol().

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kallsyms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 5bc1646f8639..202d39f5493a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -471,6 +471,9 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	unsigned long offset, size;
 	int len;
 
+	/* Prevent module removal until modname and modbuildid are printed */
+	guard(rcu)();
+
 	address += symbol_offset;
 	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
 				       buffer);
-- 
2.51.1

