class RecentUser {
  final String? icon, name, date, posts, role;

  RecentUser(
      {this.icon, this.name, this.date, this.posts, this.role});
}

List recentUsers = [
  RecentUser(
    icon: "assets/icons/xd_file.svg",
    name: "Tamub",
    role: "CR5",
    date: "01-03-2021",
    posts: "name search",
  ),
  RecentUser(
    icon: "assets/icons/Figma_file.svg",
    name: "ZimboSoft",
    role: "Tax",
    date: "27-02-2021",
    posts: "complete",
  ),
  RecentUser(
    icon: "assets/icons/doc_file.svg",
    name: "Star Labs",
    role: "CR6",
    date: "23-02-2021",
    posts: "registering",
  ),
  RecentUser(
    icon: "assets/icons/sound_file.svg",
    name: "Parliament",
    role: "Tax",
    date: "21-02-2021",
    posts: "scanning",
  ),

];
