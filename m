Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755999AbcKKLmi (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Nov 2016 06:42:38 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        bjorn.andersson@linaro.org, Jessica Yu <jeyu@redhat.com>
Subject: [PATCH RFC 2/3] libkmod: list: export list handling functions
Date: Fri, 11 Nov 2016 13:43:20 +0200
Message-Id: <1478864601-3259-3-git-send-email-yauheni.kaliuta@redhat.com>
In-Reply-To: <1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
References: <1478683053.4155.8.camel@suse.com>
 <1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

The library uses list functions to create lists internally and
provides to the clients immutable lists and only functions to
traverse them.

It may be useful to create own lists in the kmod utilities, so
export functions for lists creation as well (as it's done for
arrays). The following functions affected (needed for the
following depmod modifications):

kmod_list_append()
kmod_list_remove()
kmod_list_remove_data()

The patch also adds kmod_list_data() accessor to keep the
struct kmod_list opaque.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-internal.h |  4 ----
 libkmod/libkmod-list.c     | 36 ++++++++++++++++++++++++++++++++++--
 libkmod/libkmod.h          |  5 +++++
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 4d9db6bc7845..fd1eaed6f556 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -59,11 +59,7 @@ struct kmod_list {
 	void *data;
 };
 
-struct kmod_list *kmod_list_append(struct kmod_list *list, const void *data) _must_check_ __attribute__((nonnull(2)));
 struct kmod_list *kmod_list_prepend(struct kmod_list *list, const void *data) _must_check_ __attribute__((nonnull(2)));
-struct kmod_list *kmod_list_remove(struct kmod_list *list) _must_check_;
-struct kmod_list *kmod_list_remove_data(struct kmod_list *list,
-					const void *data) _must_check_ __attribute__((nonnull(2)));
 struct kmod_list *kmod_list_remove_n_latest(struct kmod_list *list,
 						unsigned int n) _must_check_;
 struct kmod_list *kmod_list_insert_after(struct kmod_list *list, const void *data) __attribute__((nonnull(2)));
diff --git a/libkmod/libkmod-list.c b/libkmod/libkmod-list.c
index 7623693ac12e..8dd445e9829a 100644
--- a/libkmod/libkmod-list.c
+++ b/libkmod/libkmod-list.c
@@ -186,7 +186,15 @@ struct kmod_list *kmod_list_prepend(struct kmod_list *list, const void *data)
 	return new;
 }
 
-struct kmod_list *kmod_list_remove(struct kmod_list *list)
+/**
+ * kmod_list_remove:
+ * @list: the element of the list to remove
+ *
+ * Removes and frees the element @list from the list it is a member of.
+ *
+ * Returns: the new list head value.
+ */
+KMOD_EXPORT struct kmod_list *kmod_list_remove(struct kmod_list *list)
 {
 	struct list_node *node;
 
@@ -202,7 +210,17 @@ struct kmod_list *kmod_list_remove(struct kmod_list *list)
 	return container_of(node, struct kmod_list, node);
 }
 
-struct kmod_list *kmod_list_remove_data(struct kmod_list *list,
+/**
+ * kmod_list_remove_data:
+ * @list: the head of the list
+ * @data: pointer to the data element to remove
+ *
+ * Gets the list head @list, searches for an entry, contaning
+ * data pointer @data and if finds, removes the element from the list.
+ *
+ * Returns: the new list head value.
+ */
+KMOD_EXPORT struct kmod_list *kmod_list_remove_data(struct kmod_list *list,
 							const void *data)
 {
 	struct kmod_list *itr;
@@ -312,3 +330,17 @@ KMOD_EXPORT struct kmod_list *kmod_list_last(const struct kmod_list *list)
 		return NULL;
 	return container_of(list->node.prev, struct kmod_list, node);
 }
+
+/**
+ * kmod_list_data:
+ * @list: list element to extract data pointer from
+ *
+ * Returns the @data pointer from the list entry
+ * to keep the kmod_list structure opaque
+ */
+KMOD_EXPORT void *kmod_list_data(const struct kmod_list *list)
+{
+	if (list == NULL)
+		return NULL;
+	return list->data;
+}
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index f9e33c6cde90..a720236dd353 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -87,6 +87,11 @@ struct kmod_list *kmod_list_next(const struct kmod_list *list,
 struct kmod_list *kmod_list_prev(const struct kmod_list *list,
 						const struct kmod_list *curr);
 struct kmod_list *kmod_list_last(const struct kmod_list *list);
+struct kmod_list *kmod_list_append(struct kmod_list *list, const void *data) __attribute__((warn_unused_result)) __attribute__((nonnull(2)));
+struct kmod_list *kmod_list_remove(struct kmod_list *list) __attribute__((warn_unused_result));
+struct kmod_list *kmod_list_remove_data(struct kmod_list *list,
+					const void *data) __attribute__((warn_unused_result)) __attribute__((nonnull(2)));
+void *kmod_list_data(const struct kmod_list *list);
 
 #define kmod_list_foreach(list_entry, first_entry) \
 	for (list_entry = first_entry; \
-- 
2.7.4

