Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9034DB72
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549810; cv=none; b=pYDbnWMgmdSghsxpZ+3df9G+ZUmoOps3LdwXxVsRrslFOW8mwYnEbfbU72UIHTn965nRnctVrb8VhoMKHTRZg8SBoY9LlbVKzA7r0s+WUTtS1vyiB5MrBOxr5wswnaDbJ2Zzelzf5EjlwpXMwrb3KGuoGIQuAT1RR9BN5PdbRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549810; c=relaxed/simple;
	bh=GNBE2liKm+5zfWQReyex3ayP0llhtabHxVp/9yZvKas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXQKc1X/tydmK9mDMffrBMxggTEC2IYET4ZDN7waueODba9c7LeYWsPRKuZ8t1HfenzR8JAVnUssAFJkiJK2CDLzjME4dTTwVz4dQZ188NdAGy6cewK3Gez/TmqLgebVdiz8NYzyz0f8LLvxYAJ6Zuc0oBAnYx/k1gnQfT64hSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GYORA8pM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GYORA8pM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f785467faso535549f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784549803; x=1785154603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/LTElIKYlWpTL73YwXYvJE766LImzThDSV5rDtI7NY=;
        b=GYORA8pM/IKUnD+g9xwC67LWFvvB7lM3eS5mqxTYnhRHt/0eCTbLlxta7uGCIljK1Y
         CxcsRuzsDF7TLvr4jUDCQ0hZe07+5mcXaMa4MkDvNieUoqdb5mGnrILCX5FHQ8rF2SY2
         5Ss/xJe7H2WDUGOi5DDIBUkj8QCa8ExSZv8kISq70XsIU5J/iz/MLvhgTGhp4MLY5nQ7
         I1cV0EJqo9nS/EGPoH7bfXcaPaM8720QyJ2chJgxwwItVeVj4VMGhTd9RK9lAArT8Vyf
         GmYbnnUhjOybZcwZaCdXhkr916nnKSs53JebGmamJxQm2/BIeg4PxjCpthqUvmN1/dO3
         0Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549803; x=1785154603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/LTElIKYlWpTL73YwXYvJE766LImzThDSV5rDtI7NY=;
        b=P6l6UdmilmnDB7Hihnqzp6myEINTh2HJt/YZpjCe2HCNkL3p2Q17BDas08CN3M7fVp
         ZZhu3R+zR2rRrpTHlAT7vbo2do5kJGCq/sCjWe0d6nj6MYOpJWrRDFIRqvhYpaCy4nFc
         N/hQwOHJtHoeabYNH1VJ05bv0STLxZxeuLRAkSvU0d/k1ByXHlWlUj/ojuz+mMC0okDJ
         Ufe9KNztiYA3YqD35KHxUFZpdDqSOy8xhJ7eFrMsQDvjXgGhlLZ3R8P8K071axNrqbHz
         lDZ4V3h5b7Aq65jNdQYZRuJnUHjbOV0g/bf02HdtDtFjC+5Zfp2+4NOIt+f3nmXE4/ZX
         NdBg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2s2YYiy3iM5T51UKKsc6dfDbzKSguY5pHzhDIpu7ITESfRvKicdaf+HyQiutm78dXZT7ei2bGk4GyrcAF@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7PUZ1/5w6NEGaY8Pma6FGF6sDVfaYav9JGv5+v8GJmfOvCHG
	TWesqnLKdxCnlrobFLMrFQnC4sQCHZfPmyP59YnsYfZobo4wWKF/YZTvMy/Rr/6KaZ4=
X-Gm-Gg: AR+sD10bmZ5HJkdhk6xflmihI9SgLL4K7n3/NLqrR+PddxExE/xc4bYwlxFA+zSMlg1
	6RLIq6MxuW7WBpjWtH4EjJEUPvm22AMhq53sjkopRaNULYl0B73zVU9dtRz9h0f+bz98KV1NUEf
	Fgc+qtoe6b3xTlc26tNZvwr7co4pfRzLBr+eGaVqL6r1s8OWpHh2yqL3dD5VKtmWiQyy7F31U/o
	dbdse6aoWB6nHsIahTTrQEDfWntrxRZxodxkiMDkEy11RzyQv+FBnD4Hyfqmq+EnFUu3T9RlLI4
	pOXBybdqSqT8chRwnYBf/zPcdcjN9uzgBRUKRSzBb8Mv2Nef+wZIDotDPL662LHLpZfv2K0Obvh
	7AgG5Aokf8Ty5gJHo0zKSVaxjDD8uUuMjKHZ01lMHYA+OPsQPYbgBVSLDYX7dBqHpv56iEwRRl9
	2hoETNzxue
X-Received: by 2002:a05:6000:471d:b0:474:57f0:49f8 with SMTP id ffacd0b85a97d-47f622fecf2mr14974421f8f.4.1784549803601;
        Mon, 20 Jul 2026 05:16:43 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm31424338f8f.22.2026.07.20.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:16:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] module/dups: Use strcmp() to compare module names
Date: Mon, 20 Jul 2026 14:15:29 +0200
Message-ID: <20260720121621.750661-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720121621.750661-1-petr.pavlu@suse.com>
References: <20260720121621.750661-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use strcmp() instead of strlen()+memcmp() to compare module names in
kmod_dup_request_lookup(), since all strings are NUL-terminated.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index a62619ec057e..43cec4cec4fd 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -70,11 +70,9 @@ static struct kmod_dup_req *kmod_dup_request_lookup(char *module_name)
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
2.54.0

