package entity;

public class Position {
	public int id;
	public PositionName name;

	public Position() {
		super();
	}

	public Position(int id, PositionName name) {
		this.id = id;
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public PositionName getName() {
		return name;
	}

	public enum PositionName {
		DEV, TEST, SCRUM_MASTER, PM
	}

	@Override
	public String toString() {
		return "Position [id=" + id + "\n name=" + name + "]";
	}
	
	
}
