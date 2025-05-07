Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE5290DB1
	for <linux-modules@vger.kernel.org>; Wed,  7 May 2025 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659653; cv=none; b=Czj4O47vlflPnhIIW0KzTCsG6aYoNKtkXNUarrZLHJutQYapCBsKq+zEvakOoUlwzfxZfy33P/V76JiRkWf1I72KCzyQhgUteSgH/9P4hk2Eo7733sXj7F2ywzuZgvoPhHUGXHT3NlN9OS7U1Uu3M7/v3tzCk5z0vvGLQ9qr2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659653; c=relaxed/simple;
	bh=ItNkVSdL7sFyw7FeoSb/Z/olCNf2Je/V/2GQixqVn0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aLeyXxq3YiWjx/AffA5KkH/o6jODzn3/2kvr4BNTofe9Gu+3NJY4v2+efl2N0dH8/aJpTYy/oibNxvhWLjJ0EQsavmKFOYK1jWFP3JJO958hNd9xSqFlzZVq1L8RTn9Jn9XqcL6o1LJnnt60evEZsY8RUVkXvctjxXIZvW13KCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQvnpoyI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQvnpoyI"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74041404f8dso282619b3a.0
        for <linux-modules@vger.kernel.org>; Wed, 07 May 2025 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746659651; x=1747264451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qD57SKkqZaxYs/p61W6exkyQfrWa3L+7RSVvCzVl5yw=;
        b=aQvnpoyIcU9mKxS+OhHjyrH1X4fkZOAIqMwfyAZRh4nhmi9lZmMBnE5BWAdjiiLKgq
         MtCROjPyLAiHIA7Nh4ZmmyX4M5mAY5i9UdsEkvY5d6AHcQZNxbIbPsF8Qywi6GwjtzUB
         7nEHsSuWvJBhFIi7wHTwrApo7jh2kTxmXGGHGRV/wYWchXLCtDX8dRbQv+Ny1gzjXtSB
         HFCSWCZ7j8h/+xKEoZNoKdMR+HPU6EGEQ/9CnNCVu+GkqILicgQD2YQxFentfDW1o5DV
         94MDfftjygaXLj+1JXl9LolILm51lZBLIn++qB+Ae0k9L4jTN2nPMqDuqdClqFaRPkqg
         qTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746659651; x=1747264451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qD57SKkqZaxYs/p61W6exkyQfrWa3L+7RSVvCzVl5yw=;
        b=fhdjVzJar9++mO7SDCL/0CUYcdkf9MMw2eh49n10gzWMiScr8OdgmYZb/5BTQu5kKC
         8yAUFQmAkIyq5C0jDZ1DirR7RV4/XcSMPp/mu5+zvDGRipIebrn8VtT8ahD2MTimAJrC
         Y81i66inVOR4QUtQ6GZ+johlSlaKQCT3E9bpBRpL0Dg4XCyGJvRMSRDoeyxh4hTqa8yo
         t5qm00cn0T8twCzl5kjP0GJ6UmS4oVBzO/s0rd+ywEhCDaLRRPYMSrsmfbulDMnI6Bia
         xh160lvAsllnp+LNsMMtoCN1GhoIi/n4mFM0p28+klWM4Jfk761Xt1g53/WjUIPQDImo
         8stA==
X-Forwarded-Encrypted: i=1; AJvYcCUUWXnnABYO5xgktsTBcEJi3TFZ73FY8Kt8yIOJQr5RP8bbvub1nRvO/pxzy5/gKHB1A2oYGCKauU6itPSh@vger.kernel.org
X-Gm-Message-State: AOJu0YwxmnsPkOYmeJmRMaHZ40WL48r8DnnPIYvBP49G5JVq2AHQiNEp
	YFopRyGZqmeA0fckQ/JdVEO4ORkWJ6dL84VUWQH1kO/NcLeYbiMsOMXfc8ahsytzqTbGs3jqI1E
	U6CzII4tg8rttxhKVcDUSU7E6cQ==
X-Google-Smtp-Source: AGHT+IEOWq4rkVhHEj/6h7OdAxurwzrVewSgeYGZ1i6oOjodzUNosBj0lPXXFzbN8T5rezmGLTGBnQ6kReQ1r2lDJrY=
X-Received: from pfbcj9.prod.google.com ([2002:a05:6a00:2989:b0:736:a70b:53c7])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3394:b0:73d:ff02:8d83 with SMTP id d2e1a72fcca58-7409ced9480mr8536350b3a.3.1746659651362;
 Wed, 07 May 2025 16:14:11 -0700 (PDT)
Date: Wed,  7 May 2025 23:14:05 +0000
In-Reply-To: <20250507231403.377725-7-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250507231403.377725-7-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3927; i=samitolvanen@google.com;
 h=from:subject; bh=ItNkVSdL7sFyw7FeoSb/Z/olCNf2Je/V/2GQixqVn0M=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBnSL21iH+bpaC3ov8DEV7Q8bObyh7HGVvf6d01/9HXx9
 eTf+ZXqHaUsDGIcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAiLIyMDP2pG9icypfcSFw/
 86n6woMKzsXtn7j647rK9HoP+xXyVzL8T80+7WbjF94Zzp4u7pV0Z87D3qu9L//zOL2K4r/7+O5 jfgA=
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250507231403.377725-8-samitolvanen@google.com>
Subject: [PATCH v3 1/5] gendwarfksyms: Clean up kABI rule look-ups
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Reduce code duplication by moving kABI rule look-ups to separate
functions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/kabi.c | 101 +++++++++++++++--------------------
 1 file changed, 44 insertions(+), 57 deletions(-)

diff --git a/scripts/gendwarfksyms/kabi.c b/scripts/gendwarfksyms/kabi.c
index 66f01fcd1607..badf8d46b154 100644
--- a/scripts/gendwarfksyms/kabi.c
+++ b/scripts/gendwarfksyms/kabi.c
@@ -222,33 +222,55 @@ void kabi_read_rules(int fd)
 	check(elf_end(elf));
 }
 
-bool kabi_is_declonly(const char *fqn)
+static char *get_enumerator_target(const char *fqn, const char *field)
+{
+	char *target = NULL;
+
+	if (asprintf(&target, "%s %s", fqn, field) < 0)
+		error("asprintf failed for '%s %s'", fqn, field);
+
+	return target;
+}
+
+static struct rule *find_rule(enum kabi_rule_type type, const char *target)
 {
 	struct rule *rule;
 
 	if (!stable)
-		return false;
-	if (!fqn || !*fqn)
-		return false;
+		return NULL;
+	if (!target || !*target)
+		return NULL;
 
 	hash_for_each_possible(rules, rule, hash,
-			       rule_values_hash(KABI_RULE_TYPE_DECLONLY, fqn)) {
-		if (rule->type == KABI_RULE_TYPE_DECLONLY &&
-		    !strcmp(fqn, rule->target))
-			return true;
+			       rule_values_hash(type, target)) {
+		if (rule->type == type && !strcmp(target, rule->target))
+			return rule;
 	}
 
-	return false;
+	return NULL;
 }
 
-static char *get_enumerator_target(const char *fqn, const char *field)
+static struct rule *find_enumerator_rule(enum kabi_rule_type type,
+					 const char *fqn, const char *field)
 {
-	char *target = NULL;
+	struct rule *rule;
+	char *target;
 
-	if (asprintf(&target, "%s %s", fqn, field) < 0)
-		error("asprintf failed for '%s %s'", fqn, field);
+	if (!stable)
+		return NULL;
+	if (!fqn || !*fqn || !field || !*field)
+		return NULL;
 
-	return target;
+	target = get_enumerator_target(fqn, field);
+	rule = find_rule(type, target);
+
+	free(target);
+	return rule;
+}
+
+bool kabi_is_declonly(const char *fqn)
+{
+	return !!find_rule(KABI_RULE_TYPE_DECLONLY, fqn);
 }
 
 static unsigned long get_ulong_value(const char *value)
@@ -267,58 +289,23 @@ static unsigned long get_ulong_value(const char *value)
 
 bool kabi_is_enumerator_ignored(const char *fqn, const char *field)
 {
-	bool match = false;
-	struct rule *rule;
-	char *target;
-
-	if (!stable)
-		return false;
-	if (!fqn || !*fqn || !field || !*field)
-		return false;
-
-	target = get_enumerator_target(fqn, field);
-
-	hash_for_each_possible(
-		rules, rule, hash,
-		rule_values_hash(KABI_RULE_TYPE_ENUMERATOR_IGNORE, target)) {
-		if (rule->type == KABI_RULE_TYPE_ENUMERATOR_IGNORE &&
-		    !strcmp(target, rule->target)) {
-			match = true;
-			break;
-		}
-	}
-
-	free(target);
-	return match;
+	return !!find_enumerator_rule(KABI_RULE_TYPE_ENUMERATOR_IGNORE, fqn,
+				      field);
 }
 
 bool kabi_get_enumerator_value(const char *fqn, const char *field,
 			       unsigned long *value)
 {
-	bool match = false;
 	struct rule *rule;
-	char *target;
 
-	if (!stable)
-		return false;
-	if (!fqn || !*fqn || !field || !*field)
-		return false;
-
-	target = get_enumerator_target(fqn, field);
-
-	hash_for_each_possible(rules, rule, hash,
-			       rule_values_hash(KABI_RULE_TYPE_ENUMERATOR_VALUE,
-						target)) {
-		if (rule->type == KABI_RULE_TYPE_ENUMERATOR_VALUE &&
-		    !strcmp(target, rule->target)) {
-			*value = get_ulong_value(rule->value);
-			match = true;
-			break;
-		}
+	rule = find_enumerator_rule(KABI_RULE_TYPE_ENUMERATOR_VALUE, fqn,
+				    field);
+	if (rule) {
+		*value = get_ulong_value(rule->value);
+		return true;
 	}
 
-	free(target);
-	return match;
+	return false;
 }
 
 void kabi_free(void)
-- 
2.49.0.987.g0cc8ee98dc-goog

