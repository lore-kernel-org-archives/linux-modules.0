Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B33C2F
	for <linux-modules@vger.kernel.org>; Fri, 21 Jun 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954125; cv=none; b=l1MogPmDvKmB6htm7WXV4uaCOkcACVqV68kdYlJWYjURKwCB8g8MLFtnlN88dGqYov939IVFHUWpZjqr0GlQkr2M1vJ273HCEVqpkZ4F0a9+x8CCfyXRL7vcI3kW66nWUewxSAzn9ASoxVNFuLQl7Oe2Zkl5G+b1ksA/8BsUZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954125; c=relaxed/simple;
	bh=pt41OSW+9N3ckPGAK1KUN9kTUBTubGGE4JFb2bsT2gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+8e6aSYLR5tUEgaAV8S9yV5WuzNcTKViZY3FxQjxNkZuYxwCMj6G7icjPQvyBrHT6ZZuuDsojmCBGHyno8dvjW9NtMrZGZporuD13wS2GwpzSWoOo4vSPlot2YXiGDYnLMtaWf7EKRQiOundQdAyQ+2eTH2bX1n1N/ew1po8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUGCQNjD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUGCQNjD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718954121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ae6zl9AzQwvnq8keXSg2imRt/fW4qyqthNwsZBBpu4c=;
	b=SUGCQNjDm8pRhfNvQFwUtC7ys2qHTQa3+8eKiF9WR5zvZwognpHVrfYC38LGl7Ik+d5WtI
	HTLF4AhOWUFrZkDPgUxViyFkL65SA172HG/Je83QgtgltE4XfVTmnIxWLqO8MWIhPQcuBA
	rD6dTVHRB/4sYIswb18dQullOmkOE/o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-rDJYLL-lOw-F3jg3mYHSlA-1; Fri,
 21 Jun 2024 03:15:17 -0400
X-MC-Unique: rDJYLL-lOw-F3jg3mYHSlA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88E3519560B9;
	Fri, 21 Jun 2024 07:15:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8681119560AF;
	Fri, 21 Jun 2024 07:15:14 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com,
	linux-modules@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH kmod] libkmod: share code between softdep and weakdep functions
Date: Fri, 21 Jun 2024 09:14:16 +0200
Message-ID: <20240621071453.136370-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

kmod_config_add_weakdep and weakdep_to_char functions were copied and
adapted from kmod_config_add_softdep and softdep_to_char.
These functions are very big and with big common parts. Extract those
common parts to have a more modular, non-repeated and reusable code.

No functional change.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 libkmod/libkmod-config.c | 338 ++++++++++++++-------------------------
 1 file changed, 123 insertions(+), 215 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index a571b6b..1428381 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -64,6 +64,10 @@ struct kmod_weakdep {
 	unsigned int n_weak;
 };
 
+#define SOFTDEP_TDEP_NUMBER 2
+#define WEAKDEP_TDEP_NUMBER 1
+#define MAX_TDEP_NUMBER SOFTDEP_TDEP_NUMBER
+
 const char *kmod_blacklist_get_modname(const struct kmod_list *l)
 {
 	return l->data;
@@ -271,25 +275,24 @@ static void kmod_config_free_blacklist(struct kmod_config *config,
 	config->blacklists = kmod_list_remove(l);
 }
 
-static int kmod_config_add_softdep(struct kmod_config *config,
-							const char *modname,
-							const char *line)
+static size_t dep_analyze(const char *line,
+			  char *itr,
+			  const char **dep[],
+			  const char *prefix[],
+			  unsigned int *n_dep[],
+			  const unsigned int n_tdep)
 {
-	struct kmod_list *list;
-	struct kmod_softdep *dep;
 	const char *s, *p;
-	char *itr;
-	unsigned int n_pre = 0, n_post = 0;
-	size_t modnamelen = strlen(modname) + 1;
-	size_t buflen = 0;
 	bool was_space = false;
-	enum { S_NONE, S_PRE, S_POST } mode = S_NONE;
-
-	DBG(config->ctx, "modname=%s\n", modname);
+	unsigned int i;
+	size_t buflen = 0;
+	int next_mode = -1;
 
-	/* analyze and count */
+	/* analyze */
 	for (p = s = line; ; s++) {
 		size_t plen;
+		size_t sz_prefix;
+		int mode = 0;
 
 		if (*s != '\0') {
 			if (!isspace(*s)) {
@@ -308,19 +311,36 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 		}
 		plen = s - p;
 
-		if (plen == sizeof("pre:") - 1 &&
-				memcmp(p, "pre:", sizeof("pre:") - 1) == 0)
-			mode = S_PRE;
-		else if (plen == sizeof("post:") - 1 &&
-				memcmp(p, "post:", sizeof("post:") - 1) == 0)
-			mode = S_POST;
-		else if (*s != '\0' || (*s == '\0' && !was_space)) {
-			if (mode == S_PRE) {
-				buflen += plen + 1;
-				n_pre++;
-			} else if (mode == S_POST) {
-				buflen += plen + 1;
-				n_post++;
+		if (next_mode >= 0) {
+			mode = next_mode;
+			next_mode = -1;
+		} else {
+			for(i = 0; i < n_tdep; i++) {
+				sz_prefix = strlen(prefix[i]);
+				if (!sz_prefix) {
+					mode = i;
+					break;
+				}
+				else if (sz_prefix && plen == sz_prefix &&
+					memcmp(p, prefix[i], sz_prefix) == 0) {
+					next_mode = mode = i;
+					break;
+				}
+			}
+		}
+		if (next_mode < 0) {
+			if (*s != '\0' || (*s == '\0' && !was_space)) {
+				if (itr) {
+					/* copy */
+					dep[mode][*n_dep[mode]] = itr;
+					memcpy(itr, p, plen);
+					itr[plen] = '\0';
+					itr += plen + 1;
+				} else {
+					/* count */
+					buflen += plen + 1;
+				}
+				(*n_dep[mode])++;
 			}
 		}
 		p = s + 1;
@@ -328,6 +348,28 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 			break;
 	}
 
+	return buflen;
+}
+
+static int kmod_config_add_softdep(struct kmod_config *config,
+							const char *modname,
+							const char *line)
+{
+	struct kmod_list *list;
+	struct kmod_softdep *dep;
+	char *itr;
+	unsigned int n_pre = 0, n_post = 0;
+	size_t modnamelen = strlen(modname) + 1;
+	size_t buflen = 0;
+	const char **dep_array[SOFTDEP_TDEP_NUMBER] = {NULL, NULL};
+	const char *prefix_array[SOFTDEP_TDEP_NUMBER] = {"pre:", "post:"};
+	unsigned int *n_dep_array[SOFTDEP_TDEP_NUMBER] = {&n_pre, &n_post};
+
+	DBG(config->ctx, "modname=%s\n", modname);
+
+	/* analyze and count */
+	buflen = dep_analyze(line, NULL, dep_array, prefix_array, n_dep_array, SOFTDEP_TDEP_NUMBER);
+
 	DBG(config->ctx, "%u pre, %u post\n", n_pre, n_post);
 
 	dep = malloc(sizeof(struct kmod_softdep) + modnamelen +
@@ -350,53 +392,9 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 	itr = dep->name + modnamelen;
 	n_pre = 0;
 	n_post = 0;
-	mode = S_NONE;
-	was_space = false;
-	for (p = s = line; ; s++) {
-		size_t plen;
-
-		if (*s != '\0') {
-			if (!isspace(*s)) {
-				was_space = false;
-				continue;
-			}
-
-			if (was_space) {
-				p = s + 1;
-				continue;
-			}
-			was_space = true;
-
-			if (p >= s)
-				continue;
-		}
-		plen = s - p;
-
-		if (plen == sizeof("pre:") - 1 &&
-				memcmp(p, "pre:", sizeof("pre:") - 1) == 0)
-			mode = S_PRE;
-		else if (plen == sizeof("post:") - 1 &&
-				memcmp(p, "post:", sizeof("post:") - 1) == 0)
-			mode = S_POST;
-		else if (*s != '\0' || (*s == '\0' && !was_space)) {
-			if (mode == S_PRE) {
-				dep->pre[n_pre] = itr;
-				memcpy(itr, p, plen);
-				itr[plen] = '\0';
-				itr += plen + 1;
-				n_pre++;
-			} else if (mode == S_POST) {
-				dep->post[n_post] = itr;
-				memcpy(itr, p, plen);
-				itr[plen] = '\0';
-				itr += plen + 1;
-				n_post++;
-			}
-		}
-		p = s + 1;
-		if (*s == '\0')
-			break;
-	}
+	dep_array[0] = dep->pre;
+	dep_array[1] = dep->post;
+	dep_analyze(line, itr, dep_array, prefix_array, n_dep_array, SOFTDEP_TDEP_NUMBER);
 
 	list = kmod_list_append(config->softdeps, dep);
 	if (list == NULL) {
@@ -414,44 +412,18 @@ static int kmod_config_add_weakdep(struct kmod_config *config,
 {
 	struct kmod_list *list;
 	struct kmod_weakdep *dep;
-	const char *s, *p;
 	char *itr;
 	unsigned int n_weak = 0;
 	size_t modnamelen = strlen(modname) + 1;
 	size_t buflen = 0;
-	bool was_space = false;
+	const char **dep_array[WEAKDEP_TDEP_NUMBER] = {NULL};
+	const char *prefix_array[WEAKDEP_TDEP_NUMBER]={""};
+	unsigned int *n_dep_array[WEAKDEP_TDEP_NUMBER]={&n_weak};
 
 	DBG(config->ctx, "modname=%s\n", modname);
 
 	/* analyze and count */
-	for (p = s = line; ; s++) {
-		size_t plen;
-
-		if (*s != '\0') {
-			if (!isspace(*s)) {
-				was_space = false;
-				continue;
-			}
-
-			if (was_space) {
-				p = s + 1;
-				continue;
-			}
-			was_space = true;
-
-			if (p >= s)
-				continue;
-		}
-		plen = s - p;
-
-		if (*s != '\0' || (*s == '\0' && !was_space)) {
-			buflen += plen + 1;
-			n_weak++;
-		}
-		p = s + 1;
-		if (*s == '\0')
-			break;
-	}
+	buflen = dep_analyze(line, NULL, dep_array, prefix_array, n_dep_array, WEAKDEP_TDEP_NUMBER);
 
 	DBG(config->ctx, "%u weak\n", n_weak);
 
@@ -471,38 +443,8 @@ static int kmod_config_add_weakdep(struct kmod_config *config,
 	/* copy strings */
 	itr = dep->name + modnamelen;
 	n_weak = 0;
-	was_space = false;
-	for (p = s = line; ; s++) {
-		size_t plen;
-
-		if (*s != '\0') {
-			if (!isspace(*s)) {
-				was_space = false;
-				continue;
-			}
-
-			if (was_space) {
-				p = s + 1;
-				continue;
-			}
-			was_space = true;
-
-			if (p >= s)
-				continue;
-		}
-		plen = s - p;
-
-		if (*s != '\0' || (*s == '\0' && !was_space)) {
-			dep->weak[n_weak] = itr;
-			memcpy(itr, p, plen);
-			itr[plen] = '\0';
-			itr += plen + 1;
-			n_weak++;
-		}
-		p = s + 1;
-		if (*s == '\0')
-			break;
-	}
+	dep_array[0] = dep->weak;
+	dep_analyze(line, itr, dep_array, prefix_array, n_dep_array, WEAKDEP_TDEP_NUMBER);
 
 	list = kmod_list_append(config->weakdeps, dep);
 	if (list == NULL) {
@@ -514,68 +456,56 @@ static int kmod_config_add_weakdep(struct kmod_config *config,
 	return 0;
 }
 
-static char *softdep_to_char(struct kmod_softdep *dep) {
-	const size_t sz_preprefix = sizeof("pre: ") - 1;
-	const size_t sz_postprefix = sizeof("post: ") - 1;
+static char *dep_to_char(const char **dep[],
+			 const char *prefix[],
+			 const unsigned int n_dep[],
+			 const unsigned int n_tdep)
+{
+	size_t sz_prefix[MAX_TDEP_NUMBER];
 	size_t sz = 1; /* at least '\0' */
-	size_t sz_pre, sz_post;
+	size_t sz_dep[MAX_TDEP_NUMBER];
 	const char *start, *end;
 	char *s, *itr;
+	unsigned int i;
 
 	/*
-	 * Rely on the fact that dep->pre[] and dep->post[] are strv's that
+	 * Rely on the fact that dep's are strv's that
 	 * point to a contiguous buffer
 	 */
-	if (dep->n_pre > 0) {
-		start = dep->pre[0];
-		end = dep->pre[dep->n_pre - 1]
-					+ strlen(dep->pre[dep->n_pre - 1]);
-		sz_pre = end - start;
-		sz += sz_pre + sz_preprefix;
-	} else
-		sz_pre = 0;
-
-	if (dep->n_post > 0) {
-		start = dep->post[0];
-		end = dep->post[dep->n_post - 1]
-					+ strlen(dep->post[dep->n_post - 1]);
-		sz_post = end - start;
-		sz += sz_post + sz_postprefix;
-	} else
-		sz_post = 0;
+	for(i = 0; i < n_tdep; i++) {
+		sz_prefix[i] = sizeof(prefix[i]);
+		if (sz_prefix[i])
+			sz_prefix[i] -= 1;
+
+		if (n_dep[i] > 0) {
+			start = dep[i][0];
+			end = dep[i][n_dep[i] - 1]
+				+ strlen(dep[i][n_dep[i] - 1]);
+			sz_dep[i] = end - start;
+			sz += sz_dep[i] + sz_prefix[i];
+		} else
+			sz_dep[i] = 0;
+	}
 
 	itr = s = malloc(sz);
 	if (s == NULL)
 		return NULL;
 
-	if (sz_pre) {
-		char *p;
-
-		memcpy(itr, "pre: ", sz_preprefix);
-		itr += sz_preprefix;
-
-		/* include last '\0' */
-		memcpy(itr, dep->pre[0], sz_pre + 1);
-		for (p = itr; p < itr + sz_pre; p++) {
-			if (*p == '\0')
-				*p = ' ';
-		}
-		itr = p;
-	}
-
-	if (sz_post) {
-		char *p;
+	for(i = 0; i < n_tdep; i++) {
+		if (sz_dep[i]) {
+			char *p;
 
-		memcpy(itr, "post: ", sz_postprefix);
-		itr += sz_postprefix;
+			memcpy(itr, prefix[i], sz_prefix[i]);
+			itr += sz_prefix[i];
 
-		/* include last '\0' */
-		memcpy(itr, dep->post[0], sz_post + 1);
-		for (p = itr; p < itr + sz_post; p++) {
-			if (*p == '\0')
-				*p = ' ';
+			/* include last '\0' */
+			memcpy(itr, dep[i][0], sz_dep[i] + 1);
+			for (p = itr; p < itr + sz_dep[i]; p++) {
+				if (*p == '\0')
+					*p = ' ';
+			}
+			itr = p;
 		}
-		itr = p;
 	}
 
 	*itr = '\0';
@@ -583,42 +513,20 @@ static char *softdep_to_char(struct kmod_softdep *dep) {
 	return s;
 }
 
-static char *weakdep_to_char(struct kmod_weakdep *dep) {
-	size_t sz;
-	const char *start, *end;
-	char *s, *itr;
+static char *softdep_to_char(struct kmod_softdep *softdep) {
+	const char **dep_array[SOFTDEP_TDEP_NUMBER]={softdep->pre, softdep->post};
+	const char *prefix_array[SOFTDEP_TDEP_NUMBER]={"pre: ", "post: "};
+	const unsigned int  n_dep_array[SOFTDEP_TDEP_NUMBER]={softdep->n_pre, softdep->n_post};
 
-	/*
-	 * Rely on the fact that dep->weak[] and are strv's that point to a
-	 * contiguous buffer
-	 */
-	if (dep->n_weak > 0) {
-		start = dep->weak[0];
-		end = dep->weak[dep->n_weak - 1]
-					+ strlen(dep->weak[dep->n_weak - 1]);
-		sz = end - start;
-	} else
-		sz = 0;
-
-	itr = s = malloc(sz);
-	if (s == NULL)
-		return NULL;
-
-	if (sz) {
-		char *p;
-
-		/* include last '\0' */
-		memcpy(itr, dep->weak[0], sz + 1);
-		for (p = itr; p < itr + sz; p++) {
-			if (*p == '\0')
-				*p = ' ';
-		}
-		itr = p;
-	}
+	return dep_to_char(dep_array, prefix_array, n_dep_array, SOFTDEP_TDEP_NUMBER);
+}
 
-	*itr = '\0';
+static char *weakdep_to_char(struct kmod_weakdep *weakdep) {
+	const char **dep_array[WEAKDEP_TDEP_NUMBER]={weakdep->weak};
+	const char *prefix_array[WEAKDEP_TDEP_NUMBER]={""};
+	const unsigned int n_dep_array[WEAKDEP_TDEP_NUMBER]={weakdep->n_weak};
 
-	return s;
+	return dep_to_char(dep_array, prefix_array, n_dep_array, WEAKDEP_TDEP_NUMBER);
 }
 
 static void kmod_config_free_softdep(struct kmod_config *config,
-- 
2.45.1

