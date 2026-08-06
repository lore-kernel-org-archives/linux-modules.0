Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E242C4E9
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007503; cv=none; b=Fk6Ukj3xRNWbdAXUkfrNlY7sTYKGHSufyinYOEClbH3UejS52lPjud6CXrtmvQzy30OD4rgkJAQJUk8fARdEoNMsqh5g9Hrv+NP4mpmmVGzGVa6D2oFbEsEN3CVinEyUI9OfkMUyJ3SCIKuKRdM6mMPC71cKuXS8ndMLelVy8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007503; c=relaxed/simple;
	bh=uItlWXb8MPOhAwOvNC2QGMkec4Tf49Sn3KyLOnrdPe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6NuK28gjNqtswT45EJpzCb/CqfI/uF5LuOgnZsbQFDajtFkMYvZLm8W1v1o4P2z49CYXQPrpbqkjM/aueY3Hx0tGA2VMF+PEBpN3iRBjK2RRKb2gGB6xC3wVpcYAN2tytHcWI6hfMKT41cuQ0rrXWAxzavpHeDTd8YQriuw4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XCPX8c64; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XCPX8c64"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4955158f26aso12506145e9.3
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786007499; x=1786612299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ctVxRTZld6mMfNeZZIDIMzyUTqfRuvudSqrKgHW0waM=;
        b=XCPX8c64SM5ZN3DxBegcSa0M+Ptke3o2E8De+TayD7zB1+CkzNRz47cXPNX3Xjr5NE
         OYsWV3oB48TJyCq5QuTTse0SzlrSXqtmiLi9pKyP5XrS4ZUeqlez1E45fcrjsbcacAvv
         P4x8FoVxcYaSWbI3djkdOu4PtIIZXMXPihq6G+s4CsIEbAMrLwnErdPw8w0TxrdNp+QF
         WHtdQFtY0hqi84lwU+H5UDRbqb8CFoAJccxvv49WS7DvX8iL53w+gqyHAIDcCuQe7XlF
         Is+7AsAl5oZuGBzvKleW9aRTxrYQRxo6UN3aYQN8yHsEfuJ2DnfzHY791KtTmuf61I93
         hRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007499; x=1786612299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctVxRTZld6mMfNeZZIDIMzyUTqfRuvudSqrKgHW0waM=;
        b=qhsPK9rA6UsWKAq1QgZAArCBT5g4S5K0SC1BZAIYdun3Zo3/XcbhIyOB3QK9nK681b
         igQZqGL6hPkvjyBvph62DzO8VO+qvcfk0AEcj3PS45HhW76WSKSk5K6Onaz4dk+IXobJ
         aAZRiZpqV4/aJJsAcb5fvCl4OlOBbId8jKxUxPVG/8zeJogf+d7EY0JTE3qwEBh/2yYZ
         p2SwuWUCc32VIMUgyLx3XIO+bSXVKbxZB5WDZbzCr0E+o9HwDimKUdAd9Vdj9FD4dXFO
         BJauwoWS+GYXo18K48ypy5I457+3+g6QFcN2EI4eR+nkNqcn/7vrj9rba0K8lW0dDCFg
         tHHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpETyCb37Dd8WrOfyMxh4Y4B6v6l/tShg9uCmMBgdjvb2Koz05EamjHE892sgeAuAZc8fZQxnEbH5Nlww8p@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiA/kuecy4A524DgkTsGQwkGIWrhhOCqWQNZOk8Dq3GYIkoTf
	APBlooPn+66G4SYstUe82hLhnwdQK0LOvpQZ6PMoSRepCxalFLVoWr/bWLDItDEku54=
X-Gm-Gg: AR+sD12/HcucMVoV0bGEcP+Oc+zQtGWwIwFwTl7wPiQ+IDj9aWl8bHh+Jaa/sva05ho
	lKc6l5IgNrC6TIKPOQbalhqhU0XOeaRc6+Nyv/cjsKAh0gCVH9+2/mrhW5vkuIpKTYYd58IPIA6
	MwZX/Mcgne1o39WsF3wt5YgxGckBKiBFKnJmUhjUbFQqw11+KmCWw+cGk2dqwB+2Ek1Vi4MJltZ
	C/X92xqhYkPB/4SGkoEKKu6DuA/epokxt8EtbKcO5JM03/rmA/7obpR7RPr0NZVXpqekwfg8fmB
	4L1xkrY/CxmWaySB08Fligf8HzSxOolQA5df56sOc8UHn+9l7XpSRaO65Nn0u7wbpxIQgXdRQiL
	w3zHONwHHtM/SBEzkoxNWjySmAK5uq4EJXd1MjZi+Q+S7hvIL1OPM8PvO51cpRQdZAkGheZfV5c
	ZAhUCm9rgsmb787ghqKEV9Rv6YW7op0gRwLHZ1+XdYhBWlIzbt/qaEGJ+U
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4994e71ed7bmr166617635e9.6.1786007499010;
        Thu, 06 Aug 2026 02:11:39 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4c32e0sm93157095e9.0.2026.08.06.02.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:11:38 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] module/dups: Use strcmp() to compare module names
Date: Thu,  6 Aug 2026 11:10:19 +0200
Message-ID: <20260806-module-stats-rcu-v3-5-2b0331106f00@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
References: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Use strcmp() instead of strlen()+memcmp() to compare module names in
kmod_dup_request_lookup(), since all strings are NUL-terminated.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 201a7f4c151f..fa3a4e623543 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -72,11 +72,9 @@ static struct kmod_dup_req *kmod_dup_request_lookup(char *module_name)
 	lockdep_assert_held(&kmod_dup_mutex);
 
 	list_for_each_entry(kmod_req, &dup_kmod_reqs, list) {
-		if (strlen(kmod_req->name) == strlen(module_name) &&
-		    !memcmp(kmod_req->name, module_name, strlen(module_name))) {
+		if (!strcmp(kmod_req->name, module_name))
 			return kmod_req;
-                }
-        }
+	}
 
 	return NULL;
 }

-- 
2.55.0
